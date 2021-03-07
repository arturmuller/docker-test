FROM amazon/aws-lambda-nodejs:14

ENV NEXT_TELEMETRY_DISABLED=1
ENV NODE_ENV=production

COPY lambda.js package.json package-lock.json ./
COPY pages ./pages/
COPY public ./public/

RUN npm install
RUN npm run build

CMD [ "lambda.handler" ]
