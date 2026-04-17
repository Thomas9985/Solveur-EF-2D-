FROM jupyter/minimal-notebook

USER root

RUN apt-get update -y && \
    apt-get install -y --no-install-recommends octave && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

USER $NB_UID
