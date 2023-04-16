# json-parser-v

*Example:*
```v
mut json_parser := jp.JsonParser{ path: '~/.config/theme-time/storage.json' }
json_parser.on('start', 7.str())  // First time to set
json_parser.set('start', arguments.start.str())
json_parser.get('start')
```
