
function register() {
    $('#user-response').keydown( function(e) {
                                var key = e.charCode ? e.charCode : e.keyCode ? e.keyCode : 0;
                                
                                if (key == 13)
                                {
                                //                            setTimeout(checkScore, 0);
                                setTimeout(checkAnswer, 0);
                                }
                                });
    
    
    $('#answer-form button').on('click', function(e){
                                if (e.originalEvent !== undefined && e.originalEvent.screenX && e.originalEvent.screenY)
                                {
                                if($('#user-response').val())
                                {
                                //                            setTimeout(checkScore, 0);
                                setTimeout(checkAnswer, 0);
                                }
                                }
                                });
}

function moveNext()
{
  $('#answer-form button').trigger('click');
}

function checkAnswer()
{

    if ($('#answer-form form fieldset').hasClass('correct'))
    {
        moveNext();
        register();
    }
    else if ($('#answer-form form fieldset').hasClass('incorrect'))
    {
        register();
    }

}

register();
