define(["underscore","backbone","model/sound","util/language-message"],function(a,b,c,d){var e=b.View.extend({el:"#secret",data:null,events:{"tap .btn-secret-close":"close"},initialize:function(a){this.data=a,this.setElement(this.el)},showAnimation:function(){var a=this;$(".txt-notice").html(d.getMessage("user_62")),$("#secret .prt-balloon").html(this.data.text),$("#secret .img-item, #secret .img-item-clone").attr({src:Game.imgUri+"/sp/assets/item/"+this.data.item_image}),$("#secret .img-chara").attr({src:Game.imgUri+"/sp/ui/secret/character/"+this.data.character+".png"}).load(function(){c.playVoice("voice/"+a.data.voice),a.$el.find(".prt-secret").show()})},close:function(){this.$el.find(".prt-secret").hide(),this.off(),this.undelegateEvents(),this.stopListening()}});return e});