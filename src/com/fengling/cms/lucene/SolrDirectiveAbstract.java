package com.fengling.cms.lucene;

import java.util.Map;

import org.apache.commons.lang.StringUtils;

import com.fengling.common.web.freemarker.DirectiveUtils;
import com.fengling.search.solrmodule.condition.SolrCommonItem;
import com.fengling.search.solrmodule.condition.SolrItem;
import com.fengling.search.solrmodule.condition.SolrSearchCondition;

import freemarker.template.TemplateDirectiveModel;
import freemarker.template.TemplateException;
import freemarker.template.TemplateModel;

public abstract class SolrDirectiveAbstract implements TemplateDirectiveModel {
	
	/**
	 * 输入参数，搜索关键字
	 */
	public static final String PARAM_QUERY = "q";
	/**
	 * 分组查询字段，多个按照,分开
	 */
	public static final String PARAM_GROUP_BY = "groupby";
	/**
	 * 查询结果返回的字段
	 */
	//public static final String PARAM_RETURN_FIELDS = "returnFileds";
	public static final String[] returnFields = new String[]{"ID"};
	
	/**
	 * 根据参数名获取参数值
	 * @param params
	 * @param name
	 * @return
	 * @throws TemplateException
	 */
	protected String getParamByName(Map<String, TemplateModel> params, String name) throws TemplateException {
		return DirectiveUtils.getString(name, params);
	}
	
	
	
	protected SolrSearchCondition getCondition(Map<String, TemplateModel> params, Integer siteId) throws TemplateException {
		
		//查询关键字
		String q = getParamByName(params, PARAM_QUERY);
		//分组字段
		String groupby = getParamByName(params, PARAM_GROUP_BY);
		
		String channelId = getParamByName(params, SolrContent.PARAM_CHANNEL_ID);
		String releaseMonth = getParamByName(params, SolrContent.PARAM_RELEASE_MONTH);
		
		//站点必须指定
		SolrItem item = new SolrCommonItem(SolrContent.PARAM_SITE_ID, String.valueOf(siteId)); 
		
		//根据所属的栏目查询
		if(channelId != null) {
			item.addSiblingItem(new SolrCommonItem(SolrContent.PARAM_SITE_ID, channelId), SolrItem.Relation.AND);
		}
		
		//根据发布月份检索
		if(StringUtils.isNotBlank(releaseMonth)) {
			item.addSiblingItem(new SolrCommonItem(SolrContent.PARAM_RELEASE_MONTH, releaseMonth), SolrItem.Relation.AND);
		}
		
		//关键字:查询标题、正文
		if(StringUtils.isNotBlank(q)) {
			SolrItem temp = new SolrCommonItem(SolrContent.PARAM_TITLE,q);
			temp.addSiblingItem(new SolrCommonItem(SolrContent.PARAM_TITLE,q), SolrItem.Relation.OR);
			item.addSiblingItem(temp, SolrItem.Relation.AND);
		}
		
		SolrSearchCondition con = new SolrSearchCondition(item);
		
		//如果指定了分组字段，则按分组检索
		if(StringUtils.isNotBlank(groupby)) {
			con.openFacet(groupby.split(","));
		} else {
			con.setReturnField(returnFields);
		}
		
		return con;
	}

}
