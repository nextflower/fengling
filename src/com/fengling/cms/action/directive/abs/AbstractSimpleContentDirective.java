package com.fengling.cms.action.directive.abs;

import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;

import com.fengling.cms.manager.main.ChannelMng;
import com.fengling.cms.manager.main.ContentMng;
import com.fengling.common.web.freemarker.DirectiveUtils;
import com.fengling.core.manager.CmsSiteMng;
import com.fengling.core.web.util.FrontUtils;

import freemarker.core.Environment;
import freemarker.template.TemplateDirectiveModel;
import freemarker.template.TemplateException;
import freemarker.template.TemplateModel;

/**
 * 获取内容的简单标签类
 */
public abstract class AbstractSimpleContentDirective implements
		TemplateDirectiveModel {

	/**
	 * 输入参数，栏目ID。
	 */
	public static final String PARAM_CHANNEL_ID = "channelId";
	/**
	 * 输入参数，顶级栏目ID。
	 */
	public static final String PARAM_ROOT_CHANNEL_ID = "rootChannelId";
	/**
	 * 输入参数，站点ID。可选。允许多个站点ID，用","分开。
	 */
	public static final String PARAM_SITE_ID = "siteId";
	/**
	 * 输入参数，类型ID。可选。允许多个类型ID,用","分开。
	 */
	public static final String PARAM_TYPE_ID = "typeId";
	/**
	 * 输入参数，推荐。0：所有；1：推荐；2：不推荐。默认所有。
	 */
	public static final String PARAM_RECOMMEND = "recommend";
	/**
	 * 输入参数，标题。可以为null。
	 */
	public static final String PARAM_TITLE = "title";
	/**
	 * 输入参数，标题图片。0：所有；1：有；2：没有。默认所有。
	 */
	public static final String PARAM_IMAGE = "image";
	/**
	 * 输入参数，排序方式。
	 * <ul>
	 * <li>0：ID降序
	 * <li>1：ID升序
	 * <li>2：发布时间降序
	 * <li>3：发布时间升序
	 * <li>4：固定级别降序,发布时间降序
	 * <li>5：固定级别降序,发布时间升序
	 * 
	 * <li>6：日访问降序（推荐）
	 * <li>7：周访问降序
	 * <li>8：月访问降序
	 * <li>9：总访问降序
	 * 
	 * <li>10：日评论降序（推荐）
	 * <li>11：周评论降序
	 * <li>12：月评论降序
	 * <li>13：总评论降序
	 * 
	 * <li>14：日下载降序（推荐）
	 * <li>15：周下载降序
	 * <li>16：月下载降序
	 * <li>17：总下载降序
	 * 
	 * <li>18：周顶降序（推荐）
	 * <li>19：周顶降序
	 * <li>20：周顶降序
	 * <li>21：周顶降序
	 * </ul>
	 */
	public static final String PARAM_ORDER_BY = "orderBy";

	protected Integer getRootChannelId(Map<String, TemplateModel> params)
			throws TemplateException {
		return DirectiveUtils.getInt(PARAM_ROOT_CHANNEL_ID, params);
	}

	protected Integer[] getChannelIds(Map<String, TemplateModel> params)
			throws TemplateException {
		Integer[] ids = DirectiveUtils.getIntArray(PARAM_CHANNEL_ID, params);
		if (ids != null && ids.length > 0) {
			return ids;
		} else {
			return null;
		}
	}

	protected Integer[] getSiteIds(Map<String, TemplateModel> params)
			throws TemplateException {
		Integer[] siteIds = DirectiveUtils.getIntArray(PARAM_SITE_ID, params);
		return siteIds;
	}

	protected Integer[] getTypeIds(Map<String, TemplateModel> params)
			throws TemplateException {
		Integer[] typeIds = DirectiveUtils.getIntArray(PARAM_TYPE_ID, params);
		return typeIds;
	}

	protected Boolean getHasTitleImg(Map<String, TemplateModel> params)
			throws TemplateException {
		String titleImg = DirectiveUtils.getString(PARAM_IMAGE, params);
		if ("1".equals(titleImg)) {
			return true;
		} else if ("2".equals(titleImg)) {
			return false;
		} else {
			return null;
		}
	}

	protected Boolean getRecommend(Map<String, TemplateModel> params)
			throws TemplateException {
		String recommend = DirectiveUtils.getString(PARAM_RECOMMEND, params);
		if ("1".equals(recommend)) {
			return true;
		} else if ("2".equals(recommend)) {
			return false;
		} else {
			return null;
		}
	}

	protected String getTitle(Map<String, TemplateModel> params)
			throws TemplateException {
		return DirectiveUtils.getString(PARAM_TITLE, params);
	}

	protected int getOrderBy(Map<String, TemplateModel> params)
			throws TemplateException {
		Integer orderBy = DirectiveUtils.getInt(PARAM_ORDER_BY, params);
		if (orderBy == null) {
			return 0;
		} else {
			return orderBy;
		}
	}

	protected Object getData(Map<String, TemplateModel> params, Environment env)
			throws TemplateException {
		int orderBy = getOrderBy(params);
		Boolean titleImg = getHasTitleImg(params);
		Boolean recommend = getRecommend(params);
		Integer[] typeIds = getTypeIds(params);
		Integer[] siteIds = getSiteIds(params);
		Integer[] channelIds = getChannelIds(params);
		Integer rootChannelId = getRootChannelId(params);
		String title = getTitle(params);
		int count = FrontUtils.getCount(params);

		// 主要条件为空，则执行此处代码。
		if (isPage()) {
			int pageNo = FrontUtils.getPageNo(env);
			return contentMng.getPage(siteIds, channelIds, rootChannelId, typeIds, title, recommend, titleImg, orderBy, pageNo, count);
		} else {
			int first = FrontUtils.getFirst(params);
			return contentMng.getList(siteIds, channelIds, rootChannelId, typeIds, title, recommend, titleImg, orderBy, first, count);
		}
	}

	abstract protected boolean isPage();

	@Autowired
	protected ChannelMng channelMng;

	@Autowired
	protected CmsSiteMng cmsSiteMng;

	@Autowired
	protected ContentMng contentMng;
}
