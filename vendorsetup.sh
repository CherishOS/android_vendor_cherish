(cd vendor/qcom && find . -type f -exec sed -i 's/ndk_platform/ndk/g' {} + )
(cd hardware && find . -type f -exec sed -i 's/ndk_platform/ndk/g' {} + )
