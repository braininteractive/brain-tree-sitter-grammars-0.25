# syntax=docker/dockerfile:1
# escape=\
FROM mcr.microsoft.com/windows/servercore:ltsc2022
# comment between instructions
RUN dir C:\ && \
    echo done
