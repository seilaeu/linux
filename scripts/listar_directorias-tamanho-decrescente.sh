#!/bin/bash

# Listar directorias por tamanho, ordem crescente

du -h --max-depth=1 | sort -rh
