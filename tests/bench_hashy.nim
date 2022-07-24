import benchy, random

include flatty/hashy

var
  r = initRand(1988)
  short = newString(551)
  long = newString(32 * 1024 * 1024 + 7)

for i in 0 ..< short.len:
  short[i] = r.rand(255).char

for i in 0 ..< long.len:
  long[i] = r.rand(255).char

timeIt "short sdbm", 10:
  for i in 0 ..< 1_000:
    let h = sdbm(short)
    assert h != 0
    keep(h)

timeIt "short ryan64sdbm", 10:
  for i in 0 ..< 1_000:
    let h = ryan64sdbm(short[0].unsafeAddr, short.len)
    assert h != 0
    keep(h)

timeIt "short djb2", 10:
  for i in 0 ..< 1_000:
    let h = djb2(short)
    assert h != 0
    keep(h)

timeIt "short ryan64djb2", 10:
  for i in 0 ..< 1_000:
    let h = ryan64djb2(short[0].unsafeAddr, short.len)
    assert h != 0
    keep(h)

timeIt "short string", 10:
  for i in 0 ..< 1_000:
    let h = hash(short)
    assert h != 0
    keep(h)

timeIt "short nim byte hash", 10:
  for i in 0 ..< 1_000:
    var h: Hash
    for c in short:
      h = h !& hash(c)
    assert h != 0
    keep(h)

timeIt "short nim fast hash", 10:
  for i in 0 ..< 1_000:
    var h = ryan64nim(short[0].unsafeAddr, short.len)
    assert h != 0
    keep(h)

timeIt "long sdbm", 10:
  let h = sdbm(long)
  assert h != 0
  keep(h)

timeIt "long ryan64sdbm", 10:
  let h = ryan64sdbm(long[0].unsafeAddr, long.len)
  assert h != 0
  keep(h)

timeIt "long djb2", 10:
  let h = djb2(long)
  assert h != 0
  keep(h)

timeIt "long ryan64djb2", 10:
  let h = ryan64djb2(long[0].unsafeAddr, long.len)
  assert h != 0
  keep(h)

timeIt "long string", 10:
  let h = hash(long)
  assert h != 0
  keep(h)

timeIt "long nim byte hash", 10:
  var h: Hash
  for c in long:
    h = h !& hash(c)
  assert h != 0
  keep(h)

timeIt "long nim fast hash", 10:
  var h = ryan64nim(long[0].unsafeAddr, long.len)
  assert h != 0
  keep(h)
