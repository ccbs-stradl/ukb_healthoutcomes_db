# Visualize database schema

# install sqleton https://github.com/inukshuk/sqleton
npm install -g sqleton

mkdir docs
sqleton -o docs/schema.png healthoutcomes.db
