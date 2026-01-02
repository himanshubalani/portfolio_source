I have been building my portfolio website using Flutter Web (you can visit it by clicking [here](https://himanshubalani.github.io/)). Turns out Flutter kind of sucks when it comes to building websites. It happens because flutter builds **WebApps** and not websites. These webapps often stutter on low-mid range mobile devices. One of the main concerns I had building a <s>website</s> webapp was it's performance. Here's the initial [pagespeed score](https://pagespeed.web.dev/) below.

![](https://cdn.hashnode.com/res/hashnode/image/upload/v1710398650414/ac3c1bd0-292f-4a8a-945f-cbfd0eb0ced4.jpeg align="center")

It was a whole journey I faced optimizing the website. Read till end to see how much I improved by using the tips below. So let's jump right in!

### RepaintBoundary class

<div data-node-type="callout">
<div data-node-type="callout-emoji">📰</div>
<div data-node-type="callout-text">Creates a widget that isolates Repaints</div>
</div>

The `RepaintBoundary` class in Flutter is like a protective shield for a part of your app's user interface. Imagine your app's UI as a painting. Normally, when something in the UI changes, the whole painting might need to be repainted. But with `RepaintBoundary`, you can isolate certain parts of the painting, so if only those parts change, only they need to be repainted.

```dart
/* example - Wrap your Widget in RepaintBoundary. Here The Skills Bento
is wrapped around it */

RepaintBoundary(child: Skillsbento()),
```

See the Image below and look at Composited Layers. The Blue Square is a different layer from the other Widgets. And it won't be repainted again even if we scroll because of RepaintBoundary.

![](https://cdn.hashnode.com/res/hashnode/image/upload/v1710409155615/fb891123-3d7f-41b5-bb78-3153762dcb17.png align="center")

<div data-node-type="callout">
<div data-node-type="callout-emoji">☢</div>
<div data-node-type="callout-text">Remember to not over use it. It may cause unnecessary memory consumption and might even degrade performance in some cases. When used excessively, each RepaintBoundary creates an additional layer, which consumes memory resources.</div>
</div>

### Use the Splash Screen Trick

Performance is measured by **FCP, LCP, TBT and SI** metrics. This trick will help us improve these metrics. **FCP** (First Contentful Paint) and **SI** (Speed Index) will be improved the most. Create a simple Splash Screen for your Flutter app using HTML and CSS. Initially when Flutter WebApps open, they have a plain white background and it takes atleast 2-3 seconds to load the page. The perceived delay for any user can be decreased by making a Splash Screen. This tricks pagespeed as well.

Head over to the `index.html` in your `web` folder and add some internal CSS and edit HTML body.

```css
<style>
  body { /*background body */
    background-color: #90A8ED;
    height: 100vh;
    width: 100vw;
    margin: 0;
  }

  .main-content { /*favicon logo */
    display: flex;
    justify-content: center;
    align-items: center;
    background-color: #90A8ED;
    height: 100vh;
    width: 100vw;
    transition: opacity 0.5s ease-out;
  }
</style>
```

```xml
<!-- I added the code-->
<body>
<!-- <style> tag -->
  <script> //adding a delay function so that the splash screen can 
//transition into flutter webapp
    function delay(time) {
      return new Promise(resolve => setTimeout(resolve, time));
    }

//add loaderContent variable, run appRunner function after delay
    window.addEventListener('load', function(ev) {
      var loaderContent = document.querySelector('#loader-content');
      // Download main.dart.js
      _flutter.loader.loadEntrypoint({
        serviceWorker: {
          serviceWorkerVersion: serviceWorkerVersion,
        },
        onEntrypointLoaded: function(engineInitializer) {
          engineInitializer.initializeEngine().then(async function(appRunner) {
            loaderContent.style.opacity = "0";
            await delay(400);
            await appRunner.runApp();
          });
        }
      });
    });
  </script
<div class= "main-content" id="loader-content">
  <img src="favicon.webp" alt="hb" style="max-width: 100px; max-height: 100px;">
  </div>
</body>
```

Heres the result-

![](https://cdn.hashnode.com/res/hashnode/image/upload/v1710413751670/68c43038-bf7f-415b-a583-c5d53f6b6d75.gif align="center")

%[https://twitter.com/himanshubalani5/status/1768117614407217255] 

### Drop the complexity, will ya?

![](https://cdn.hashnode.com/res/hashnode/image/upload/v1710414109649/9758794e-508e-4427-9fe6-11c0cb5ef73a.png align="center")

This is a heavy widget. Nested but optimized. The properties like Border, BorderRadius, BoxShadows impact the performance a lot. This is because Flutter has to calculate a lot to build with these properties. My widget has tons of curves and shadows. Avoiding them works well.

> Or you know, add a RepaintBoundary - ;D

### Conclusion

Well these tips helped me improve my portfolio website's performance a lot. Hope they help you out too!

Here's the final pagespeed score below. Increased by 80%. Ofcourse your results may vary.

![](https://cdn.hashnode.com/res/hashnode/image/upload/v1710414775557/4f8125cb-5cdd-45a0-8945-c052c20842f7.png align="center")

---

Do you have tips you can share to optimize Flutter Web? Share them in the comment section below!

Thank you for reading 💓, you've reached so far so please like my blog which keeps me motivated to write more content, and also don't forget to leave your views down below 👇 . Here have a cookie 🍪.