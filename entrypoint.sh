#!/bin/sh -l

echo "Hello"
echo TOKEN "${NPM_TOKEN}" AAAA
echo "after token"
ant build
