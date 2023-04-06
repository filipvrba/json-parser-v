module main

import src.jp

fn main()
{
	mut db := jp.JsonParser{ path: 'share/db.json'}
	db.on('greet', 'hi')
	println(db)

	db.set('greet', 'hello greeting lol')

	db.on('greet', 'hi')
	println(db)
}
