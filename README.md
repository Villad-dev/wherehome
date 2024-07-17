# wherehome *app*

![image](/assets/images/presentation.png)

A real estate mobile application(currently only Android). 

Comfy real estate market place application in future will be adopted to Web version.

## Stack Used

- Frontend: Flutter
- Backend: dart_frog <a href="https://github.com/VeryGoodOpenSource/dart_frog">
  <img src="/assets/images/logo.png" width="30" height="30">
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
Table of environmental variables
| ENV                | Value                |
|--------------------|----------------------|
| SDK_REGISTRY_TOKEN | your_mapbox_pk.token |
| BACKEND_URL        | backend URL          |

### Example:

NB use only https links for Android builds!
```
--dart-define=SDK_REGISTRY_TOKEN="your_mapbox_pk.token"
--dart-define=BACKEND_URL="backend URL"
```

## Licence and right to use
I appreciate if anyone will be using code in non comercial usage othervise pemission to use has to be requested. 