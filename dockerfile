ARG python_version=3.9
ARG build_target=$python_version
ARG publish_target=$python_version

FROM python:$build_target as Builder

# Add arguments to container scope
ARG build_target
ARG package
ARG package_version

# Only add build tools for alpine image. The ubuntu based images have build tools already.
# Only runs if `apk` is on the system.
RUN if which apk ; then apk add python3-dev libffi-dev libevent-dev build-base bash cargo rust gcc musl-dev maturin; fi

# Install packaer and build all dependencies.
RUN pip install $package==$package_version watchfiles


# Build our actual container now.
FROM python:$publish_target

# Add args to container scope.
ARG publish_target
ARG python_version
ARG package
ARG maintainer=""
ARG TARGETPLATFORM=""
LABEL python=$python_version
LABEL package=$package
LABEL maintainer=$maintainer
LABEL org.opencontainers.image.description="python:$publish_target $package:$package_version $TARGETPLATFORM"


# Copy all of the python files built in the Builder container into this smaller container.
COPY --from=Builder /usr/local/lib/python$python_version /usr/local/lib/python$python_version

# Startup Script
COPY ./assets/start.sh /start.sh
RUN chmod +x /start.sh

# Example application so container "works" when run directly.
COPY ./assets/main.py /app/main.py
WORKDIR /app/

ENV PYTHONPATH=/app

CMD ["/start.sh"]
