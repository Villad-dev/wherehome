# wherehome *app*

![image](/assets/images/presentation.png)

A real estate mobile application(currently only Android). 

Comfy real estate market place application in future will be adopted to Web version.

## Stack Used

- Frontend: Flutter
- Backend: dart_frog 
<a href="https://github.com/VeryGoodOpenSource/dart_frog">
  <img src="/assets/images/logo.png">
</a>
- Database: MongoDB
- Localization: easy_localization package for Flutter
- State Management: Provider
- Authentication: Bearer Auth

## Installation

```
  git clone https://github.com/your-username/wherehome.git
  cd wherehome
```

## ENV variables

| ENV                | Value                |
|--------------------|----------------------|
| SDK_REGISTRY_TOKEN | your_mapbox_pk.token |
| BACKEND_URL        | backend URL          |

### Example:

```
--dart-define=SDK_REGISTRY_TOKEN="your_mapbox_pk.token"
--dart-define=BACKEND_URL="backend URL"

NB use only https links for Android builds!
```

#### Licence and right to
I appreciate if anyone will be using code in non comercial usage othervise pemission to use has to be requested. 