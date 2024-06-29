## Environmental Variables

### `PORT`

The port that the application inside of the container will listen on. This is different from the host port that gets mapped to the container.


### `LOG_LEVEL`

The uvicorn log level. Must be one of the following:

* `critical`
* `error`
* `warning`
* `info`
* `debug`
* `trace`


### `MODULE_NAME`

The python module that the container will start. This should be a script that starts QuasiQueue.


### `PRE_START_PATH`

Where to find the prestart script.


### `RELOAD`

When this is set to the string `true` uvicorn is launched in reload mode. If any files change uvicorn will reload the modules again, allowing for quick debugging. This comes at a performance cost, however, and should not be enabled on production machines.
