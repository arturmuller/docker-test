ARG node_version=14.15.4
ARG node_image=node:${node_version}-alpine

# STAGE 1
FROM $node_image as builder

ENV NEXT_TELEMETRY_DISABLED=1

WORKDIR /app/

COPY package.json package-lock.json ./
RUN npm install

COPY pages ./pages/
COPY public ./public/

RUN npm run build

# STAGE 2
FROM $node_image as production

WORKDIR /app/

COPY --from=builder /app/package.json /app/package-lock.json ./
RUN npm ci --omit=dev

# STAGE 3
FROM $node_image

ENV NEXT_TELEMETRY_DISABLED=1
ENV NODE_ENV=production

WORKDIR /app/

COPY --from=production /app/node_modules ./node_modules
COPY --from=builder /app/.next ./.next
COPY --from=builder /app/public ./public
COPY --from=builder /app/package.json ./

EXPOSE 3000
CMD npm run start
