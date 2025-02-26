## Sử dụng Node.js base image phù hợp cho ứng dụng Next.js
#FROM node:18-alpine AS builder
#
## Thiết lập thư mục làm việc trong container
#WORKDIR /app
#
## Copy toàn bộ file cần thiết vào container
#COPY package.json yarn.lock ./
#
## Cài đặt dependencies
#RUN yarn install
#
## Copy toàn bộ mã nguồn và build ứng dụng
#COPY . .
#RUN yarn build
#
## Khởi tạo stage chạy ứng dụng
#FROM node:18-alpine AS runner
#
## Thiết lập thư mục làm việc cho runtime
#WORKDIR /app
#
## Copy output từ giai đoạn build
#COPY --from=builder /app/.next ./.next
#COPY --from=builder /app/public ./public
#COPY --from=builder /app/package.json ./package.json
#
## Expose cổng 8002 để ứng dụng có thể truy cập được
#EXPOSE 8002
#
## Cài đặt dependencies cần cho production
#RUN yarn install --production
#
## Khởi động ứng dụng
#CMD ["yarn", "start", "-p", "8002"]

# Base image chỉ dành cho runtime
FROM node:18-alpine

# Thiết lập thư mục làm việc trong container
WORKDIR /app

# Copy file cần thiết từ kết quả build của CICD
COPY .next ./.next
COPY public ./public
COPY package.json ./package.json
COPY yarn.lock ./yarn.lock

# Cài đặt production dependencies
RUN yarn install --production

# Expose cổng 8084 để ứng dụng có thể truy cập được
EXPOSE 8084

# Khởi động ứng dụng
CMD ["yarn", "start", "-p", "8084"]
