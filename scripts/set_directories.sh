cd || exit

git clone git@github.com:boltac-tp/lab.git

mkdir compete
cd compete || exit
git clone git@github.com:boltac-tp/atcoder-python.git
git clone git@github.com:boltac-tp/atcoder-rust.git
git clone git@github.com:boltac-tp/paiza.git

cd || exit
mkdir site
cd site || exit
git clone git@github.com:boltac-tp/boltac.git
git clone git@github.com:boltac-tp/debit.git
mkdir example
cd example || exit
git clone https://github.com/onweru/compose.git
git clone https://github.com/google/docsy.git
cd site || exit
mkdir themes
cd themes || exit
git clone git@github.com:boltac-tp/compose.git

cd || exit
mkdir works
cd works || exit
git clone git@github.com:boltac-tp/myupdate.git

cd || exit
