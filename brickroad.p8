pico-8 cartridge // http://www.pico-8.com
version 42
__lua__
-- brickroad
-- by zetlam
-- spent: ⧗⧗⧗

function _init()
	print("brick road")
	print("2d shooter")
	initialize_game()
	_draw = draw_game
end

function _update()
	p.vx = 0
	p.vy = 0
	if (btn(⬅️)) p.vx = -1
	if (btn(➡️)) p.vx = 1
	if (btn(⬆️)) p.vy = -1
	if (btn(⬇️)) p.vy = 1
	if (btnp(❎)) spawn_foe()
	if (btnp(🅾️)) shoot_bullet(p.x+2,p.y-1)
	update_game()
end




-->8


function initialize_game()
	p = {
		x=60,y=100,
		w=8,h=8
		,vx=0,vy=0
	}
	-- bullets
	buls = {}
	foes = {}
end

function update_game()
	-- update avatar
	p.x += p.vx
	p.y += p.vy
	-- update foes
	for foe in all(foes) do
		foe.x += foe.vx
		foe.y += foe.vy
	end
	-- delete out of range foes
	for i=#foes,1,-1 do
		if (foes[i].y > 255) then
			deli(foes,i)
		end
	end
	-- update bullets
	for bul in all(buls) do
		bul.x += bul.vx
		bul.y += bul.vy
	end
	-- delete out of range bullets
	for i=#buls,1,-1 do
		if (buls[i].y < -255) then
			deli(buls,i)
		end
	end
end

function spawn_foe()
	foe = {
		x=60, y=0,
		w=7,  h=7,
		vx=0, vy=1
	}
	foe.x = rnd(127-foe.w)
	foe.vy = rnd({1,0.5})
	add(foes,foe)
end

function shoot_bullet(bx,by)
	sfx(1)
	bul = {
		x=bx, y=by,
		vx=0, vy=-1
	}
	add(buls, bul)
end



-->8

function draw_game()
	cls(1)
	-- draw player avatar
	rectfill(p.x,p.y,p.x+p.w-1,p.y+p.h-1,10)
	-- draw foes
	for foe in all(foes) do
		rectfill(foe.x,foe.y,foe.x+foe.w-1,foe.y+foe.h-1,8)
	end
	-- draw bullets
	for bul in all(buls) do
		pset(bul.x,bul.y,7)
	end
	-- print stats
	print(#foes, 80,0,8)
	print(#buls, 80,6,7)
	print("cpu: "..
		flr(100*stat(1)).."%"
		,100,0,6)
end

__gfx__
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00700700000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00077000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00077000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00700700000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
__sfx__
000100000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00040000310302d040110000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
