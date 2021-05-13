@echo off
scss --style compressed theme.scss:theme.min.css | more
copy theme.min.css ..\assets\css

