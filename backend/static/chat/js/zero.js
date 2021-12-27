var testjson = 
{
   "engineer":{
   	   "name":"患者",
   	   "avatar":"",
   	   "ok":4,
   	   "alarm":5,
   	   "state":2
    },
    "alluser":[{
       "name":"医生",
       "avatar":"",
       "state":0,
       "choosed":false,
       "from":"SWS-未知",
       "flag":3,
       "report":true,
       "dialog":[
         {
         	"belong":0,
         	"tag":"text",
         	"content":"你好",
         	"url":"",
         	"file":""
         },{
         	"belong":1,
         	"tag":"text",
         	"content":"你好",
         	"url":"",
         	"file":""
         }
       ]
    },]
};
var zero = new Vue({
	el:"#zero",
	data:{
      test:testjson,
      onchat:'',
      newchat:{
         	belong:0,
         	tag:"text",
         	content:"",
         	url:"",
         	file:""
         },

	},
	methods:{
     dot:function(e){
     	if (e == 0) {
     		return 'dot_red';
     	}else if(e == 1){
     		return 'dot_green'
     	}else if(e == 2){
     		return 'dot_orange'
     	}
     },
     flag:function(e,x){
     	if (x) {
          if (e == 0) {
     		return 'user_info user_choosed';
     	}else if(e == 1){
     		return 'user_info flag_left_orange user_choosed'
     	}else if(e == 2){
     		return 'user_info flag_left_red user_choosed'
     	}else if(e == 3){
     		return 'user_info flag_left_green user_choosed'
     	}
     	}else{
          if (e == 0) {
     		return 'user_info';
     	}else if(e == 1){
     		return 'user_info flag_left_orange'
     	}else if(e == 2){
     		return 'user_info flag_left_red'
     	}else if(e == 3){
     		return 'user_info flag_left_green'
     	}
     	}
     },
     report:function(e){
     	if (e) {
     		return "icon_report_2 user_rep";
     	}
     },
     choosed:function(e){
     	this.onchat = this.test.alluser[e];
        for (var i = 0; i < this.test.alluser.length; i++) {
        	if (e == i) {
        		this.test.alluser[i].choosed = true;
        	}else{
        		this.test.alluser[i].choosed = false;
        	}
        	
        }
     },
     belong:function(e){
        if (e == 0 ) {
        	return 'dialog_1';
        }else{
        	return 'dialog_2';
        }
     },
     addchat:function(){
     	var m = JSON.parse(JSON.stringify(this.newchat))
     	this.onchat.dialog.push(m);
     	this.newchat.content='';

     },
     shot:function(e){
     	var m = this.test.alluser[e].dialog.length;
     	var c = this.test.alluser[e].dialog[m-1].content;
     	if (c.length > 10) {
     		var r = c.substring(0,9)+'...';
     		return r;
     	}else{
     		return c;
     	}

     }

	},
	created(){
		this.onchat = this.test.alluser[0];
	}
	
})