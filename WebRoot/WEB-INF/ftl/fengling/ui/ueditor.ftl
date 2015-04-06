<#--
<textarea name="textarea"></textarea>
-->
<#macro ueditor
	name value="" height="230"
	fullPage="false" toolbarSet="My"
	label="" noHeight="false" required="false" colspan="" width="100" help="" helpPosition="2" colon=":" hasColon="true"
	maxlength="65535"
	onclick="" ondblclick="" onmousedown="" onmouseup="" onmouseover="" onmousemove="" onmouseout="" onfocus="" onblur="" onkeypress="" onkeydown="" onkeyup="" onselect="" onchange=""
	>
<#include "control.ftl"/><#rt/>
<input type="hidden" id="ueditor_value" name="${name}" value=""/>
<script id="ueditor" type="text/plain" style="height:500px;">${value}</script>

<script type="text/javascript">
$(function() {
   	var ue = UE.getEditor('ueditor');
   	ue.ready(function() {
	    //设置编辑器的内容
	    //ue.setContent('');
	});
 });
 
function initUEditorValue() {
	var html = UE.getEditor('ueditor').getContent();
	$("#ueditor_value").val(html);
}
</script>
<#include "control-close.ftl"/><#rt/>
</#macro>