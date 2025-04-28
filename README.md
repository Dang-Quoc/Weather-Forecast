# Weather-Forecast
Weather Forecast App là một ứng dụng dự báo thời tiết cho phép người dùng theo dõi tình hình thời tiết theo thời gian thực ở bất kỳ địa điểm nào trên thế giới. Ứng dụng cung cấp thông tin thời tiết chi tiết, bao gồm nhiệt độ, độ ẩm, tốc độ gió, và dự báo trong nhiều ngày tiếp theo

## Link demo youtube
https://weather-forecast-86fc4.web.app/

## Link deploy
https://weather-forecast-86fc4.web.app

## Cách chạy project trên local
- Clone project về máy
- Chạy lệnh `flutter pub get` để lấy các package cần thiết
- Chạy project bằng `flutter run`

## Các công nghệ sử dụng
- Flutter
- Provider
- Dio
- Cached Network Image
- Shared Preferences

## Các tính năng
- Xem thời tiết hiện tại và dự báo thời tiết trong nhiều ngày tiếp theo (14 ngày)
- Tìm kiếm thời tiết theo tên thành phố
- Lưu lại lịch sử tìm kiếm (trong vòng 1 ngày)
- Xem lại lịch sử tìm kiếm
- Đăng ký và hủy đăng ký thông báo, có hỗ trợ email xác nhận
- Deploy lên Firebase Hosting

## Cấu trúc thư mục
- models: chứa các model của project
- services: chứa các service lấy dữ liệu từ API của project
- viewmodels: chứa các viewmodel quản lý dữ liệu của project
- views: chứa giao diện hiển thị
- storage: chứa các file lưu trữ dữ liệu
- utils: chứa các hàm hỗ trợ khác của project như validator
- main.dart: file khởi tạo project
