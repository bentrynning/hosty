
# use the official Bun image
# see all versions at https://hub.docker.com/r/oven/bun/tags
FROM oven/bun:1 AS base
WORKDIR /usr/src/app

# install dependencies into temp directory
# this will cache them and speed up future builds
FROM base AS install
RUN mkdir -p /temp/dev

COPY bun.lockb /temp/dev/
COPY apps/admin/package.json /temp/dev/
RUN cd /temp/dev && bun install --frozen-lockfile --filter './admin'

# install with --production (exclude devDependencies)
RUN mkdir -p /temp/prod
COPY bun.lockb /temp/prod/
COPY apps/admin/package.json /temp/prod/
RUN cd /temp/prod && bun install --production --frozen-lockfile --filter './admin'

# copy node_modules from temp directory
# then copy all (non-ignored) project files into the image
FROM base AS prerelease
COPY --from=install /temp/dev/node_modules node_modules
COPY apps/admin/ .

# [optional] tests & build
ENV NODE_ENV=production
# RUN bun test
# RUN bun run build

# copy production dependencies and source code into final image
FROM base AS release
COPY --from=install /temp/prod/node_modules node_modules
COPY --from=prerelease /usr/src/app/index.ts .
COPY --from=prerelease /usr/src/app/package.json .

# run the app
USER bun
EXPOSE 3000/tcp
ENTRYPOINT [ "bun", "run", "index.tsx" ]