# {name}
This is just a {name} module copied from {module} v{version}.
This package is generated for simplicity of use.

# Installation
```bash
npm install {name} --save
```
# Usage
The package expects that global `Highcharts` variable is set.
It also doesn't export anything.

Then just require the package if you use common.js
```javascript
require('{name}')
```

Or include the script in your HTML file.
```html
<script src = "node_modules/{name}/index.js">
```

# Generation info
The code for generating the modules is in [this repository](https://github.com/kirjs/publish-highcharts-modules)

# Issues

[Issues with the way modules work](https://github.com/highslide-software/highcharts.com/issues)

[Issues with the way modules were generated](https://github.com/kirjs/publish-highcharts-modules)


