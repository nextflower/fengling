package com.fengling.cms.manager.main;

import com.fengling.cms.entity.main.Channel;
import com.fengling.cms.entity.main.ChannelExt;

public interface ChannelExtMng {
	public ChannelExt save(ChannelExt ext, Channel channel);

	public ChannelExt update(ChannelExt ext);
}