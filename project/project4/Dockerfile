# Use Tomcat 9 with JDK 11
FROM tomcat:9-jdk11

# Remove default Tomcat applications
RUN rm -rf /usr/local/tomcat/webapps/*

# Set environment variables
ENV CATALINA_HOME /usr/local/tomcat
ENV PATH $CATALINA_HOME/bin:$PATH
ENV LANG=C.UTF-8
ENV LC_ALL=C.UTF-8

# Install Maven
RUN apt-get update && \
    apt-get install -y maven && \
    rm -rf /var/lib/apt/lists/*

# Set working directory
WORKDIR /app

# Copy project files
COPY . /app

# Build the project
RUN mvn clean package

# Copy the WAR file to Tomcat webapps
RUN cp /app/target/restaurant.war /usr/local/tomcat/webapps/ROOT.war

# Create data directory for persistence
RUN mkdir -p /app/data

# Expose port 8000
EXPOSE 8000

# Copy optimized Tomcat configuration for high concurrency
COPY src/main/webapp/WEB-INF/tomcat-server.xml /usr/local/tomcat/conf/server.xml

# JVM 성능 최적화 옵션
# -Xms512m: 초기 힙 크기 512MB
# -Xmx1024m: 최대 힙 크기 1GB
# -XX:+UseG1GC: G1 가비지 컬렉터 사용 (낮은 지연시간)
# -XX:MaxGCPauseMillis=200: GC 일시정지 목표 200ms
# -XX:+UseStringDeduplication: 문자열 중복 제거 (메모리 절약)
ENV JAVA_OPTS="-Dfile.encoding=UTF-8 -Xms512m -Xmx1024m -XX:+UseG1GC -XX:MaxGCPauseMillis=200 -XX:+UseStringDeduplication -Djava.security.egd=file:/dev/./urandom"

# Start Tomcat
CMD ["catalina.sh", "run"]

