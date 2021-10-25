#!/bin/bash
# Copyright (c) 2019-2021, The Khronos Group Inc.
# Copyright (c) 2019 Collabora, Ltd.
# SPDX-License-Identifier: Apache-2.0

# Start the docker image named below.
# Mounts this directory as the mountpoint mentioned below,
# and logs you in as a normal user whose user ID and group ID match
# your outside-of-container user, thus avoiding mangling permissions.
# Container is automatically removed when you exit it.

IMAGE_NAME=rpavlik/docker-images:bookworm
MOUNTPOINT=$(pwd)

set -e
# docker pull $IMAGE_NAME
uid=$(id -u)
gid=$(id -g)
USER_ID_ARGS="-e USER_ID=$uid -e GROUP_ID=$gid"
docker run -it --rm \
    ${USER_ID_ARGS} \
    -e CONTAINER_CWD=$MOUNTPOINT \
    --mount type=bind,source=$MOUNTPOINT,target=$MOUNTPOINT \
    $IMAGE_NAME "$@"
