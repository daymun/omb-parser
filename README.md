omb-parser
==========

Read params by initializing the parser with a filename:

```
Parser.new('config.txt').params
```

Read a specific parameter:

```
Parser.new('config.txt').params[:test_mode]
```
