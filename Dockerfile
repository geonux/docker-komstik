FROM ubuntu
MAINTAINER Vincent Gaudissart (gaudissart@gmail.com)

RUN \
  apt-get update && apt-get -y --no-install-recommends install \
    ca-certificates \
    software-properties-common \
    nodejs npm nodejs-legacy \
    git

RUN add-apt-repository ppa:mapnik/nightly-trunk

RUN \
  apt-get update && apt-get -y --no-install-recommends install \
    libmapnik mapnik-utils \
    mapnik-input-plugin-gdal mapnik-input-plugin-ogr \
    mapnik-input-plugin-postgis \
    mapnik-input-plugin-sqlite \
    mapnik-input-plugin-osm

RUN \
  npm update -g npm

WORKDIR /opt/app

RUN \
  git clone https://github.com/kosmtik/kosmtik.git && \
    cd kosmtik && \
	npm install

RUN \
  git clone https://github.com/yohanboniface/thank-you-map.git /opt/project
	
WORKDIR /opt/app/kosmtik

RUN \
  node index.js plugins \
    --install kosmtik-map-compare \
    --install kosmtik-mapnik-reference \
    --install  kosmtik-mbtiles-export \
    --install kosmtik-osm-data-overlay \
    --install kosmtik-overlay \
    --install kosmtik-place-search \
    --install kosmtik-deploy \
    --install kosmtik-geojson-overlay

VOLUME /opt/project

EXPOSE 6789

CMD ["node", "index.js", "serve", "--host", "0.0.0.0", "/opt/project/project.yml"]
