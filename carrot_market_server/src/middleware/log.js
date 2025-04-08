exports.logRequestTime = (req, res, next) => {
  const start = Date.now()
  res.on('finish', () => {
    const duration = Date.now() - start;
    console.log(`${req.method} ${req.orginalUrl} - ${duration} ms`)
  });
  next();
}