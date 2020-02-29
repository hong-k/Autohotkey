#NoEnv
#SingleInstance force
#NoTrayIcon

Gui, Add, GroupBox, x2 y5 w180 h40 , 게임시간
Gui, Add, Text, x74 y23 w12 h10 +Center vminute, 00
Gui, Add, Text, x86 y23 w12 h10 +Center, :
Gui, Add, Text, x98 y23 w12 h10 +Center vsecond, 00
Gui, Add, GroupBox, x2 y48 w180 h190 , Timer
Gui, Add, Text, x14 y71 w50 h30 , TOP
Gui, Add, Text, x104 y71 w50 h30 vtopz, 0
Gui, Add, Text, x14 y105 w50 h30 , JUG
Gui, Add, Text, x104 y105 w50 h30 vjugz, 0
Gui, Add, Text, x14 y135 w50 h30 , MID
Gui, Add, Text, x104 y135 w50 h30 vmidz, 0
Gui, Add, Text, x14 y165 w50 h30 , AD
Gui, Add, Text, x104 y165 w50 h30 vadz, 0
Gui, Add, Text, x14 y195 w50 h30 , SUP
Gui, Add, Text, x104 y195 w50 h30 vsupz, 0
Gui, Add, Edit, x12 y262 w160 h30 -VScroll vclip, 
Gui, Add, GroupBox, x2 y240 w180 h60 , Clipboard
Gui, Add, Button, x7 y302 w172 h27 +center glink, Made by TomorJerry
Gui, Add, GroupBox, x186 y5 w120 h210 , Reset
Gui, Add, Button, x195 y19 w95 h30 gtop_r, TOP
Gui, Add, Button, x195 y59 w95 h30 gjug_r, JUG
Gui, Add, Button, x195 y99 w95 h30 gmid_r, MID
Gui, Add, Button, x195 y139 w95 h30 gad_r, AD
Gui, Add, Button, x195 y179 w95 h30 gsup_r, SUP
Gui, Add, GroupBox, x186 y220 w120 h109 , Hotkey(수정중)
Gui, Add, Edit, x192 y239 w50 h20 , TOP
Gui, Add, Edit, x242 y239 w50 h20 , JUG
Gui, Add, Edit, x192 y269 w50 h20 , MID
Gui, Add, Edit, x242 y269 w50 h20 , AD
Gui, Add, Edit, x192 y299 w50 h20 , SUP
Gui, Add, Button, x242 y297 w53 h23 , 적용
Gui, Show, x577 y379 h333 w308 , Tom
Gui, Color, CFFFFFF
top_on=1				; 스펠 온 상태
jug_on=1
mid_on=1
ad_on=1
sup_on=1
Return

GuiClose:
ExitApp
return

F10::				; test
{
}
return

F1::				; top
{
gui, submit, nohide
guicontrolget, topz
guicontrolget, clip
guicontrolget, minute
guicontrolget, second

minute_p:=minute+5
plus_t:=minute_p second
top_c=1				; 스펠 쓰고 5분 지났는지 비교할 변수

if (top_on=1) {				; 스펠이 온 일 때만 작동
guicontrol, , topz, %plus_t%
Ctrl_x(plus_t, 1)				; (스펠도는시간, 탑=1 정글=2 미드=3 원딜=4 서폿=5)
Ctrl_c()
}
top_on=0				; 스펠 off - 중복작동방지
}
return

F2::				; jug
{
gui, submit, nohide
guicontrolget, jugz
guicontrolget, clip
guicontrolget, minute
guicontrolget, second

minute_p:=minute+5
plus_j:=minute_p second
jug_c=1

if (jug_on=1) {
guicontrol, , jugz, %plus_j%
Ctrl_x(plus_j, 2)
Ctrl_c()
}
jug_on=0
}
return

F3::				; mid
{
gui, submit, nohide
guicontrolget, midz
guicontrolget, clip
guicontrolget, minute
guicontrolget, second

minute_p:=minute+5
plus_m:=minute_p second
mid_c=1

if (mid_on=1) {
guicontrol, , midz, %plus_m%
Ctrl_x(plus_m, 3)
Ctrl_c()
}
mid_on=0
}
return

F4::				; ad
{
gui, submit, nohide
guicontrolget, adz
guicontrolget, clip
guicontrolget, minute
guicontrolget, second

minute_p:=minute+5
plus_a:=minute_p second
ad_c=1

if (ad_on=1) {
guicontrol, , adz, %plus_a%
Ctrl_x(plus_a, 4)
Ctrl_c()
}
ad_on=0
}
return

F5::				; sup
{
gui, submit, nohide
guicontrolget, supz
guicontrolget, clip
guicontrolget, minute
guicontrolget, second

minute_p:=minute+5
plus_s:=minute_p second
sup_c=1

if (sup_on=1) {
guicontrol, , supz, %plus_s%
Ctrl_x(plus_s, 5)
Ctrl_c()
}
sup_on=0
}
return

F7::				; start
{
stopsign:=0
_minute=0
_second=0
top_c=0
jug_c=0
mid_c=0
ad_c=0
sup_c=0
gui, submit, nohide
GuiControlget, minute
guicontrolget, second
guicontrolget, topz
guicontrolget, jugz
guicontrolget, midz
guicontrolget, adz
guicontrolget, supz

loop {
	if (stopsign=0) {				; 스탑싸인이 없을 때 
		_second++
		guicontrol, , second, % SubStr("0" _second, -1)
		sleep, 1000
		if (_second=59) {			; 1분 될 때
			_minute++
			guicontrol, , minute, % SubStr("0" _minute, -1)
			_second=-1
		}
			if (top_c>=1)				; 탑이 스펠써서 F1 핫키 눌렀을 때
			{
				top_c += 1					; 1초마다 c++
				if (top_c=301)				; 스펠쓰고 300초 지났을 때
				{
					guicontrol, , topz, 0
					top_c=0
					top_on=1
					Ctrl_cc(1)
				}
			}
			if (jug_c>=1)				; 정글이 스펠써서 F1 핫키 눌렀을 때
			{
				jug_c += 1
				if (jug_c=301)				; 스펠쓰고 5분이 지났을 때
				{
					guicontrol, , jugz, 0
					jug_c=0
					jug_on=1
					Ctrl_cc(2)
				}
			}
			if (mid_c>=1)				; mid 스펠써서 F1 핫키 눌렀을 때
			{
				mid_c += 1
				if (mid_c=301)				; 스펠쓰고 5분이 지났을 때
				{
					guicontrol, , midz, 0
					mid_c=0
					mid_on=1
					Ctrl_cc(3)
				}
			}
			if (ad_c>=1)				; ad 스펠써서 F1 핫키 눌렀을 때
			{
				ad_c += 1
				if (ad_c=301)				; 스펠쓰고 5분이 지났을 때
				{
					guicontrol, , adz, 0
					ad_c=0
					ad_on=1
					Ctrl_cc(4)
				}
			}
			if (sup_c>=1)				; sup 스펠써서 F1 핫키 눌렀을 때
			{
				sup_c += 1
				if (sup_c=301)				; 스펠쓰고 5분이 지났을 때
				{
					guicontrol, , supz, 0
					sup_c=0
					sup_on=1
					Ctrl_cc(5)
				}
			}
	}
	else {				; 스탑싸인 들어올때 (F7)
		break	
	}
}
}
return

F8::				; stopsign (reset)
{
sleep, 1100
gui, submit, nohide	
stopsign=1
guicontrolget, minute
guicontrolget, second
guicontrolget, cilp
guicontrolget, topz
guicontrolget, jugz
guicontrolget, midz
guicontrolget, adz
guicontrolget, supz
guicontrol, , minute, 00
guicontrol, , second, 00
guicontrol, , clip, 
guicontrol, , topz, 0
guicontrol, , jugz, 0
guicontrol, , midz, 0
guicontrol, , adz, 0
guicontrol, , supz, 0 
top_on=1
jug_on=1
mid_on=1
ad_on=1
sup_on=1
}
return

Ctrl_c() 				; clipboard 안에 있는 내용 복사 
{
guicontrolget, clip
clipboard:=clip
return
}

Ctrl_x(a, b)				; 클립보드 내용 수정 a=시간, b=라인번호
{
guicontrolget, topz
guicontrolget, jugz
guicontrolget, midz
guicontrolget, adz
guicontrolget, supz
guicontrolget, clip
topdata=%a%top
jugdata=%a%jug
middata=%a%mid
addata=%a%ad
supdata=%a%sup
if (b=1) {				; 탑 핫키 눌릴때
	guicontrol, , topz, %a%
	guicontrol, , clip, %clip% %topdata%
}
if (b=2) {				; 정글 핫키 눌릴때
	guicontrol, , jugz, %a%
	guicontrol, , clip, %clip% %jugdata%
}
if (b=3) {				; mid 핫키 눌릴때
	guicontrol, , midz, %a%
	guicontrol, , clip, %clip% %middata%
}
if (b=4) {				; ad 핫키 눌릴때
	guicontrol, , adz, %a%
	guicontrol, , clip, %clip% %addata%
}
if (b=5) {				; sup 핫키 눌릴때
	guicontrol, , supz, %a%
	guicontrol, , clip, %clip% %supdata%
}
return
}

Ctrl_cc(a) 				; 5분 지나고 클립보드 초기화 후 남은 라인 차례대로 클립보드에 추가 a=라인 번호
{
guicontrolget, topz
guicontrolget, jugz
guicontrolget, midz
guicontrolget, adz
guicontrolget, supz
guicontrolget, clip

if (a=1) {				; top 스펠 돌 때
	guicontrol, , clip, 				; 클립보드 초기화
	guicontrolget, clip
	clipboard:=clip
	if (jugz>1){				; jug부터 추가 
		guicontrol, , clip, %jugz%jug
		guicontrolget, clip
		clipboard:=clip
	}
	if (midz>1){
		guicontrol, , clip, %clip% %midz%mid
		guicontrolget, clip
		clipboard:=clip
	}
		if (adz>1){
		guicontrol, , clip, %clip% %adz%ad
		guicontrolget, clip
		clipboard:=clip
	}
		if (supz>1){
		guicontrol, , clip, %clip% %supz%sup
		guicontrolget, clip
		clipboard:=clip
	}
	
guicontrolget, clip
clipboard:=clip
}

if (a=2) {				; jug 스펠 돌 때
	guicontrol, , clip, 
	guicontrolget, clip
	clipboard:=clip
	
	if (topz>1){
		guicontrol, , clip, %topz%top
		guicontrolget, clip
		clipboard:=clip
	}
	if (midz>1){
		guicontrol, , clip, %clip% %midz%mid
		guicontrolget, clip
		clipboard:=clip
	}
		if (adz>1){
		guicontrol, , clip, %clip% %adz%ad
		guicontrolget, clip
		clipboard:=clip
	}
		if (supz>1){
		guicontrol, , clip, %clip% %supz%sup
		guicontrolget, clip
		clipboard:=clip
	}
	
guicontrolget, clip
clipboard:=clip
}

if (a=3) {				; mid 스펠 돌 때
	guicontrol, , clip, 
	guicontrolget, clip
	clipboard:=clip
	
	if (topz>1){
		guicontrol, , clip, %topz%top
		guicontrolget, clip
		clipboard:=clip
	}
	if (jugz>1){
		guicontrol, , clip, %clip% %jugz%jug
		guicontrolget, clip
		clipboard:=clip
	}
		if (adz>1){
		guicontrol, , clip, %clip% %adz%ad
		guicontrolget, clip
		clipboard:=clip
	}
		if (supz>1){
		guicontrol, , clip, %clip% %supz%sup
		guicontrolget, clip
		clipboard:=clip
	}
	
guicontrolget, clip
clipboard:=clip
}

if (a=4) {				; ad 스펠 돌 때
	guicontrol, , clip, 
	guicontrolget, clip
	clipboard:=clip
	
	if (topz>1){
		guicontrol, , clip, %topz%top
		guicontrolget, clip
		clipboard:=clip
	}
	if (jugz>1){
		guicontrol, , clip, %clip% %jugz%jug
		guicontrolget, clip
		clipboard:=clip
	}
		if (midz>1){
		guicontrol, , clip, %clip% %midz%mid
		guicontrolget, clip
		clipboard:=clip
	}
		if (supz>1){
		guicontrol, , clip, %clip% %supz%sup
		guicontrolget, clip
		clipboard:=clip
	}
	
guicontrolget, clip
clipboard:=clip
}

if (a=5) {				; sup 스펠 돌 때
	guicontrol, , clip, 
	guicontrolget, clip
	clipboard:=clip
	
	if (topz>1){
		guicontrol, , clip, %topz%top
		guicontrolget, clip
		clipboard:=clip
	}
	if (jugz>1){
		guicontrol, , clip, %clip% %jugz%jug
		guicontrolget, clip
		clipboard:=clip
	}
		if (midz>1){
		guicontrol, , clip, %clip% %midz%mid
		guicontrolget, clip
		clipboard:=clip
	}
		if (adz>1){
		guicontrol, , clip, %clip% %adz%ad
		guicontrolget, clip
		clipboard:=clip
	}
	
guicontrolget, clip
clipboard:=clip
}

return
}

top_r:
{
gui, submit, nohide
guicontrolget, topz
guicontrol, , topz, 0
top_c=0
top_on=1
Ctrl_cc(1)
return	
}
jug_r:
{
gui, submit, nohide
guicontrolget, jugz
guicontrol, , jugz, 0
jug_c=0
jug_on=1
Ctrl_cc(2)
return	
}
mid_r:
{
gui, submit, nohide
guicontrolget, midz
guicontrol, , midz, 0
mid_c=0
mid_on=1
Ctrl_cc(3)
return	
}
ad_r:
{
gui, submit, nohide
guicontrolget, adz
guicontrol, , adz, 0
ad_c=0
ad_on=1
Ctrl_cc(4)
return	
}
sup_r:
{
gui, submit, nohide
guicontrolget, supz
guicontrol, , supz, 0
sup_c=0
sup_on=1
Ctrl_cc(5)
return	
}

link:
{
run explorer.exe https://tomorjerry.tistory.com/
return	
}