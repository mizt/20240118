cd "$(dirname "$0")"
cd ./

clang++ -O3 -std=c++20 -framework Cocoa -Wc++17-extensions ./failure.mm -o ./failure
clang++ -O3 -std=c++20 -framework Cocoa -Wc++17-extensions ./success.mm -o ./success
clang++ -O3 -std=c++20 -framework Cocoa -Wc++17-extensions ./argument.mm -o ./argument
