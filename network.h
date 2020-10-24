#ifndef NETWORK_H
#define NETWORK_H

#include <QTcpSocket>
#include <QUdpSocket>
#include <QNetworkProxy>
#include <QVariant>
#include <QDebug>
#include <QGuiApplication>
#include <QSettings>
#include <QTimer>

class Network : public QObject
{
    Q_OBJECT

public:
	Network(QObject *parent = 0) : QObject(parent)
	{
		m_pclSocket = new QTcpSocket(this);
		//m_pclSocket->setProxy(QNetworkProxy::NoProxy);
		QNetworkProxyFactory::setUseSystemConfiguration(false);
		connect(m_pclSocket, SIGNAL(connected()), this, SLOT(tcpConnect()));
		connect(m_pclSocket, SIGNAL(disconnected()), this, SLOT(tcpDisconnect()));
        connect(m_pclSocket, SIGNAL(readyRead()), this, SLOT(slotReadyRead()));
		connect(m_pclSocket, SIGNAL(error(QAbstractSocket::SocketError)), this, SLOT(error()));
#ifdef Q_OS_WIN
		QSettings settings(qApp->applicationDirPath() + "\\setting.ini", QSettings::IniFormat);
#else
		QSettings settings("/sdcard/settings.ini", QSettings::NativeFormat);
#endif
		m_strIpaddr = settings.value("IPADDR", "192.168.0.100").toString();
		m_strMacaddr = settings.value("MACADDR", "00099A000000").toString();
		m_strPort = settings.value("PORT", "2101").toString();
        m_strlistCmd.append(settings.value("CMD01", "00CO1HI").toString());
        m_strlistCmd.append(settings.value("CMD02", "00CO1HI").toString());
        m_strlistCmd.append(settings.value("CMD03", "00CO1HI").toString());
        m_strlistCmd.append(settings.value("CMD04", "00CO1HI").toString());
        m_strlistCmd.append(settings.value("CMD05", "00CO1HI").toString());
        m_strlistCmd.append(settings.value("CMD06", "00CO1HI").toString());
        m_strlistCmd.append(settings.value("CMD07", "00CO1HI").toString());
        m_strlistCmd.append(settings.value("CMD08", "00CO1HI").toString());
        m_strlistCmd.append(settings.value("CMD09", "00CO1HI").toString());
        m_strlistCmd.append(settings.value("CMD10", "00CO1HI").toString());
        m_strlistCmd.append(settings.value("CMD11", "00CO1HI").toString());
        m_strlistCmd.append(settings.value("CMD12", "00CO1HI").toString());
        m_strlistCmd.append(settings.value("CMD13", "00CO1HI").toString());
        m_strlistCmd.append(settings.value("CMD14", "00CO1HI").toString());
    }
	~Network()
	{
#ifdef Q_OS_WIN
		QSettings settings(qApp->applicationDirPath() + "\\setting.ini", QSettings::IniFormat);
#else
		QSettings settings("/sdcard/settings.ini", QSettings::NativeFormat);
		qDebug() << qApp->applicationDirPath();
#endif
		settings.setValue("IPADDR", m_strIpaddr);
		settings.setValue("MACADDR", m_strMacaddr);
		settings.setValue("PORT", m_strPort);
#ifndef Q_OS_WIN
		settings.sync();
#endif
	}
	Q_INVOKABLE QString getIpaddr(){return m_strIpaddr;}
	Q_INVOKABLE QString getMacaddr(){return m_strMacaddr;}
	Q_INVOKABLE QString getPort(){return m_strPort;}
    Q_INVOKABLE QString getCmd(int i){return m_strlistCmd[i];}
	Q_INVOKABLE void setIpaddr(QString str){m_strIpaddr = str;}
	Q_INVOKABLE void setMacaddr(QString str){m_strMacaddr = str;}
	Q_INVOKABLE void setPort(QString str){m_strPort = str;}
	Q_INVOKABLE void connectToHost(QString strIp, quint16 port)
	{
		if(m_pclSocket->isOpen()){
			m_pclSocket->close();	// 一旦閉じる
		}
		m_pclSocket->connectToHost(strIp, port);
	}
	QByteArray StrToArray(QString data)
	{
		QByteArray arStr;
		while(data.size()){
			arStr.append(data.left(2).toInt(NULL, 16));
			data.remove(0, 2);
		}
		return arStr;
	}
	Q_INVOKABLE void write(QString data)
	{
		m_arReadData = "";
		QStringList strlist = data.split("\\");
        QByteArray arData;
        for(int i = 0; i < strlist.count(); i++){
            if(i % 2){
                arData.append(StrToArray(strlist[i]));	// バイナリ変換
            }
            else{
                arData.append(strlist[i].toLocal8Bit());// 無変換
            }
        }
        m_pclSocket->write(arData);
        qDebug() << "write:" << arData;
    }
	Q_INVOKABLE QByteArray read(void)
	{
		return m_arReadData;
	}
	Q_INVOKABLE void close()
	{
		m_pclSocket->close();
	}
	Q_INVOKABLE void wakeOnLan(QString strIpaddr, QString strMac)
	{
		QByteArray baMac = QByteArray::fromHex(strMac.toLocal8Bit());
		QByteArray ba6FF = QByteArray::fromHex("FFFFFFFFFFFF");
		QByteArray ba16Mac;
		for (int i = 0; i < 16; i++){
			ba16Mac += baMac;
		}
		QHostAddress FakeAddress;
		FakeAddress.setAddress(strIpaddr);
		QByteArray baWOLSignal = ba6FF + ba16Mac;
		QUdpSocket udpSocket;
		udpSocket.writeDatagram(baWOLSignal, baWOLSignal.size(), FakeAddress, 9);
		qDebug() << "wakeOnLan";
	}
	Q_INVOKABLE void sleep(qint32 time)
	{
		QEventLoop loop;
		QTimer::singleShot(time, &loop, SLOT(quit()));
		loop.exec();
	}
	Q_INVOKABLE QString conv16str(qint32 value)
	{
		QString tmpStr;
		tmpStr.sprintf("%02x",value);
		return tmpStr;
	}

private:
	QTcpSocket *m_pclSocket;
	QString m_strIpaddr;
	QString m_strMacaddr;
	QString m_strPort;
    QList<QString> m_strlistCmd;
    QByteArray m_arReadData;

signals:
    void sigReadyRead(QString msg);
    void sigError(QString msg);

private slots:
	void tcpConnect()
    {
	}
	void tcpDisconnect()
    {
	}
    void slotReadyRead()
	{
        m_arReadData = m_pclSocket->readAll();
        emit sigReadyRead(m_arReadData);
	}
	void error()
    {
        emit sigError(m_pclSocket->errorString());
	}
};
#endif // NETWORK_H
