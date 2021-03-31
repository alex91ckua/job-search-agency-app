//= require active_admin/base
//= require activeadmin/froala_editor/froala_editor.pkgd.min
//= require froala_custom_buttons
//= require activeadmin/froala_editor_input
//= require activeadmin_reorderable

$(document).ready(function(){

  if ( $('body').hasClass('admin_jobs') ) {

    if ( $('select[name="job[job_type]"]').val() == 'contract' ) {
      $('li#job_salary_input').hide();
    } else {
      $('li#job_day_rate_input').hide();
    }
  
    $('select[name="job[job_type]"]').change(function(){
  
      if(this.value == 'contract') {
        $('li#job_salary_input').hide();
        $('li#job_day_rate_input').show();
      } else {
        $('li#job_salary_input').show();
        $('li#job_day_rate_input').hide();
      }
    })

  }

})