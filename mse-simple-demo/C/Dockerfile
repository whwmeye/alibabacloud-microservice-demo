# syntax=docker/dockerfile:1.4

FROM maven:3-eclipse-temurin-8-alpine as build

RUN sed -i 's/dl-cdn.alpinelinux.org/mirrors.aliyun.com/g' /etc/apk/repositories

COPY <<EOF /root/.m2/settings.xml
<?xml version=\"1.0\"?>
<settings>
    <mirrors>
        <mirror>
            <id>alimaven</id>
            <name>aliyun maven</name>
            <url>https://maven.aliyun.com/nexus/content/groups/public/</url>
            <mirrorOf>central</mirrorOf>
        </mirror>
    </mirrors>
</settings>
EOF

WORKDIR /app

COPY ./ ./

RUN --mount=type=cache,target=/root/.m2/repository/ \
  mvn clean package --batch-mode

FROM dragonwell-registry.cn-hangzhou.cr.aliyuncs.com/dragonwell/dragonwell:8-extended-ga-centos

# copy arthas
COPY --from=hengyunabc/arthas:latest /opt/arthas /opt/arthas

COPY --from=build /app/target/C.jar /app/target/C.jar
#COPY ./target/C.jar /app/target/C.jar

EXPOSE 20003
ENTRYPOINT ["sh", "-c"]
CMD ["java -jar /app/target/C.jar"]
