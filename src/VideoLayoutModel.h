#pragma once

#include <unordered_map>

#include <QMap>
#include <QObject>
#include <QString>


class VideoLayoutModel : public QObject
{
	Q_OBJECT
	Q_PROPERTY(QString state READ state NOTIFY stateChanged)
	Q_PROPERTY(QString largeView READ largeView NOTIFY largeViewChanged)
	Q_PROPERTY(QString topView READ topView NOTIFY topViewChanged)
	Q_PROPERTY(QString middleView READ middleView NOTIFY middleViewChanged)
	Q_PROPERTY(QString bottomView READ bottomView NOTIFY bottomViewChanged)

public:
	explicit VideoLayoutModel(QObject* parent = nullptr);
	~VideoLayoutModel() = default;

	enum class State { Tiled, Focused };
	Q_ENUM(State)
	
	const QString& state() const;
	QString largeView() const;
	QString topView() const;
	QString middleView() const;
	QString bottomView() const;
	
	Q_INVOKABLE QString tiledView(const QString& view) const;

public slots:
	void click(const QString& view);

signals:
	void stateChanged(const QString& newState);
	void largeViewChanged(const QString& newLargeView);
	void topViewChanged(const QString& newTopView);
	void middleViewChanged(const QString& newMiddleView);
	void bottomViewChanged(const QString& newBottomView);
	void swapped();

private:
	void emitViewChanges();
	State m_state{ State::Tiled };
	
	const QMap<QString, QString> m_tiled_view_map {
		{ "topLeft", "bucket" },
		{ "topRight", "rear" },
		{ "bottomLeft", "left" },
		{ "bottomRight", "right" }
	};
	
	QMap<QString, QString> m_focused_view_map {
		{ "large", "bucket" },
		{ "top", "rear" },
		{ "middle", "left" },
		{ "bottom", "right" }
	};
};
