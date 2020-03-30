#!/bin/sh -l

echo "Hello"
echo TOKEN "${NPM_TOKEN}"
ant build
