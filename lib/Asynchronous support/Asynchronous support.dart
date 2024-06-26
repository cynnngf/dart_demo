/*异步支持
Dart 代码库中有大量返回 Future 或 Stream 对象的函数，这些函数都是 异步 的，它们会在耗时操作（比如I/O）执行完毕前直接返回而不会等待耗时操作执行完毕。

async 和 await 关键字用于实现异步编程，并且让你的代码看起来就像是同步的一样。


处理 Future
可以通过下面两种方式，获得 Future 执行完成的结果：

使用 async 和 await

使用 Future API

使用 async 和 await 的代码是异步的，但是看起来有点像同步代码。例如，下面的代码使用 await 等待异步函数的执行结果。*/

await lookUpVersion();
//必须在带有 async 关键字的 异步函数 中使用 await：

Future<void> checkVersion() async {
var version = await lookUpVersion();
// Do something with version
}

/*备注:

尽管 async 函数可能会执行一些耗时操作，但是它并不会等待这些耗时操作完成，相反，异步函数执行时会在其遇到第一个 await 表达式时返回一个 Future 对象，然后等待 await 表达式执行完毕后继续执行。

使用 try、catch 以及 finally 来处理使用 await 导致的异常：*/

try {
version = await lookUpVersion();
} catch (e) {
// React to inability to look up the version
}

//你可以在异步函数中多次使用 await 关键字。例如，下面代码中等待了三次函数结果：

var entrypoint = await findEntryPoint();
var exitCode = await runExecutable(entrypoint, args);
await flushThenExit(exitCode);

/*await 表达式的返回值通常是一个 Future 对象；如果不是的话也会自动将其包裹在一个 Future 对象里。 Future 对象代表一个“承诺”， await 表达式会阻塞直到需要的对象返回。

如果在使用 await 时导致编译错误，请确保 await 在一个异步函数中使用。例如，如果想在 main() 函数中使用 await，那么 main() 函数就必须使用 async 关键字标识。*/

void main() async {
checkVersion();
print('In main: version is ${await lookUpVersion()}');
}

/*明异步函数
异步函数 是函数体由 async 关键字标记的函数。

将关键字 async 添加到函数并让其返回一个 Future 对象。假设有如下返回 String 对象的方法：*/

String lookUpVersion() => '1.0.0';
//将其改为异步函数，返回值是 Future：

Future<String> lookUpVersion() async => '1.0.0';
/*注意，函数体不需要使用 Future API。如有必要，Dart 会创建 Future 对象。

如果函数没有返回有效值，需要设置其返回类型为 Future<void>。


处理 Stream
如果想从 Stream 中获取值，可以有两种选择：

使用 async 关键字和一个 异步循环（使用 await for 关键字标识）。

使用 Stream API。

备注:

在使用 await for 关键字前，确保其可以令代码逻辑更加清晰并且是真的需要等待所有的结果执行完毕。例如，通常不应该在 UI 事件监听器上使用 await for 关键字，因为 UI 框架发出的事件流是无穷尽的。

使用 await for 定义异步循环看起来是这样的：*/

await for (varOrType identifier in expression) {
// Executes each time the stream emits a value.
}

/*表达式 的类型必须是 Stream。执行流程如下：

等待直到 Stream 返回一个数据。

使用 1 中 Stream 返回的数据执行循环体。

重复 1、2 过程直到 Stream 数据返回完毕。

使用 break 和 return 语句可以停止接收 Stream 数据，这样就跳出了循环并取消注册监听 Stream。

如果在实现异步 for 循环时遇到编译时错误，请检查确保 await for 处于异步函数中。 例如，要在应用程序的 main() 函数中使用异步 for 循环，main() 函数体必须标记为 async：*/

void main() async {
// ...
await for (final request in requestServer) {
handleRequest(request);
}
// ...
}
