$(function(){

  // ============
  // = Menu Box =
  // ============
  $('.menu_box .menu_box_arrow .open').click(function(){
    var menu_box, open, closed;

    menu_box = $(this).closest('.menu_box');
    open = $('.menu_box_body .open, .menu_box_arrow .open', menu_box);
    closed = $('.menu_box_body .closed, .menu_box_arrow .closed', menu_box);

    open.hide();
    closed.show();
  });

  $('.menu_box .menu_box_arrow .closed, .menu_box .menu_box_body .closed').click(function(){
    var menu_box, open, closed;

    menu_box = $(this).closest('.menu_box');
    open = $('.menu_box_body .open, .menu_box_arrow .open', menu_box);
    closed = $('.menu_box_body .closed, .menu_box_arrow .closed', menu_box);

    open.show();
    closed.hide();
  });


  // ====================
  // = Effective Config =
  // ====================
  $('#s_e_c').click(function(e){
    e.preventDefault();
    $('#h_e_c, #effective_config').show();
    $('#s_e_c').hide();
  });

  $('#h_e_c').click(function(e){
    e.preventDefault();
    $('#h_e_c, #effective_config').hide();
    $('#s_e_c').show();
  });


  // ====================================
  // = En/disable role specifier inputs =
  // ====================================
  $('#role_name').change(function(){
    var name, custom_name;

    name = $('#role_name');
    custom_name = $('#role_custom_name');

    if (name.val() == '') {
      custom_name.removeAttr("disabled");
    } else {
      custom_name.attr("disabled","disabled");
    }
  });

  $('#role_custom_name').change(function(){
    var name, custom_name;

    name = $('#role_name');
    custom_name = $('#role_custom_name');

    if (custom_name.val() == '') {
      name.removeAttr("disabled");
    } else {
      name.attr("disabled","disabled");
    }
  });

  $('#role_name').change();


  // =========================
  // = Project Template Info =
  // =========================
  $('#project_template').change(function(){
    var selection
    ;

    selection = $('#project_template').val();

    $('.template_info').hide();
    $('#'+selection+'_desc').show();
  });

  $('#project_template').change();
});

// open a new window
function loadWindow(url) {
  popupWin = window.open(url, 'new_window', 'scrollbars=no,status=no,toolbar=no,location=no,directories=no,menubar=no,width=960, height=700, top=50, left=50, resizable=1, scrollbars=yes');
  popupWin.focus();
}

/* Create Menu Links */

function open_menu(dom_id)
{
  // arrow images
  $('#' + dom_id + "_arrow_right").hide();
  $('#' + dom_id + "_arrow_down").show();

  // stages
  $('#' + dom_id + "_stages").show();
}

function close_menu(dom_id)
{
  // arrow images
  $('#' + dom_id + "_arrow_right").show();
  $('#' + dom_id + "_arrow_down").hide();

  // stages
  $('#' + dom_id + "_stages").hide();
}

function observe_field(field_id, callback)
{
  var field = $('#' + field_id), ti = null;

  var start = function() {
    if (ti) {
      clearTimeout(ti);
    }
    ti = setTimeout(callback, 500);
  };

  var stop = function() {
    if (ti) {
      ti = setTimeout(callback, 500);
    }
  };

  field.bind('keyup', start); // detect interaction
}
