#include "VideoLayoutModel.h"

namespace
{
	const std::unordered_map<VideoLayoutModel::State, QString> stateToString{
		{ VideoLayoutModel::State::Focused, "focused" },
		{ VideoLayoutModel::State::Tiled, "tiled" }
	};
}

VideoLayoutModel::VideoLayoutModel(QObject* parent)
	: QObject(parent)
{
}

const QString& VideoLayoutModel::state() const
{
	return stateToString.at(m_state);
}

QString VideoLayoutModel::largeView() const
{
	if (m_state != State::Focused)
	{
		throw std::runtime_error("VideoLayoutModel::largeView() -- Cannot query large view while not in Focused state");
	}

	return m_focused_view_map["large"];
}

QString VideoLayoutModel::topView() const
{
	if (m_state != State::Focused)
	{
		throw std::runtime_error("VideoLayoutModel::topView() -- Cannot query top view while not in Focused state");
	}

	return m_focused_view_map["top"];
}

QString VideoLayoutModel::middleView() const
{
	if (m_state != State::Focused)
	{
		throw std::runtime_error("VideoLayoutModel::middleView() -- Cannot query middle view while not in Focused state");
	}

	return m_focused_view_map["middle"];
}

QString VideoLayoutModel::bottomView() const
{
	if (m_state != State::Focused)
	{
		throw std::runtime_error("VideoLayoutModel::bottomView() -- Cannot query bottom view while not in Focused state");
	}

	return m_focused_view_map["bottom"];
}

QString VideoLayoutModel::tiledView(const QString& view) const
{
	if (m_state != State::Tiled)
	{
		throw std::runtime_error("VideoLayoutModel::focusedView() -- Cannot query tiled view while not in Tiled state");
	}
	
	return m_tiled_view_map[view];
}

void VideoLayoutModel::click(const QString& view)
{
	if (m_focused_view_map.contains(view))
	{
		if (m_state != State::Focused)
		{
			throw std::runtime_error("VideoLayoutModel::click() -- received a focus view name while not in Focused state");
		}

		if (view == "large")
		{
			m_state = State::Tiled;
			emit stateChanged(state());
		}
		else
		{
			auto previous_large_view = m_focused_view_map["large"];
			m_focused_view_map["large"] = m_focused_view_map[view];
			m_focused_view_map[view] = previous_large_view;
			emitViewChanges();
			emit swapped();
		}
	}
	else if (m_tiled_view_map.contains(view))
	{
		if (m_state != State::Tiled)
		{
			throw std::runtime_error("VideoLayoutModel::click() -- received tile view name while not in Tiled state");
		}
		
		const auto& new_large_view = m_tiled_view_map[view];
		m_focused_view_map["large"] = new_large_view;
		QList<QString> remaining_views = m_tiled_view_map.values();
		remaining_views.removeOne(new_large_view);
		m_focused_view_map["top"] = remaining_views[0];
		m_focused_view_map["middle"] = remaining_views[1];
		m_focused_view_map["bottom"] = remaining_views[2];
		
		m_state = State::Focused;
		emitViewChanges();
		emit stateChanged(state());
	}
	else
	{
		throw std::runtime_error("VideoLayoutModel::click() -- ");
	}
}

void VideoLayoutModel::emitViewChanges()
{
	emit largeViewChanged(m_focused_view_map["large"]);
	emit topViewChanged(m_focused_view_map["top"]);
	emit middleViewChanged(m_focused_view_map["middle"]);
	emit bottomViewChanged(m_focused_view_map["bottom"]);
}
