const serverless = require("serverless-http");
const next = require("next");

const app = next({ dev: false });
const prep = app.prepare();
const serverlessHandler = serverless({ handle: app.getRequestHandler() });

exports.handler = async (event, context) => {
  await prep;
  return serverlessHandler(event, context);
};