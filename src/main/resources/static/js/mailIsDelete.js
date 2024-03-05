

let mailIsdeleteObject = {
   
   init : function(){
      let _this = this;
      
      $("#btn-isdelete").on("click",() =>{
         _this.mailIsDelete();
      });
      
   },
   mailIsDelete : function(){
      alert("휴지통으로 이동요청")
       let receiveMailId = $("#receiveMailId").val()
      
      
      $.ajax({
         type: "DELETE",
         url: "/deletePost/"+id,
         data: JSON.stringify(receiveMailId),
         contentType: "application/json; charset=utf-8"
         
      }).done(function(response){
         console.log(response)
         location = "/getPostList"
      }).fail(function(error){
      });
   },
}
mailIsdeleteObject.init();
