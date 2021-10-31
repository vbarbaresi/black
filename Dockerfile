FROM python:3-slim

# TODO: Remove regex version pin once we get newer arm wheels
RUN mkdir /src
COPY . /src/
RUN pip install --no-cache-dir --upgrade pip setuptools wheel \
    # Install build tools to compile dependencies that don't have prebuilt wheels
    && apt update && apt install -y git build-essential \
    && cd /src \
    && pip install --no-cache-dir .[colorama,d] \
    && rm -rf /src \
    && apt remove -y git \
    && apt autoremove -y \
    && rm -rf /var/lib/apt/lists/*

CMD ["black"]
