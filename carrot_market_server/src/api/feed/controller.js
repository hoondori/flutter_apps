exports.index = (req, res) => {
  res.send('피드 목록');
}

exports.store = (req, res) => {
  res.send('피드 생성');
}

exports.show = (req, res) => {
  const id = req.params.id;
  res.send('피드 상세');
}

exports.update = (req, res) => {
  const id = req.params.id;
  res.send('피드 수정');
}

exports.delete = (req, res) => {
  const id = req.params.id;
  res.send('피드 삭제');
}