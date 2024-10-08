/*
 * Copyright 2021 Ramiro Calle
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *   http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */
mod Environment {

    import dev.flix.runtime.Global
    import java.lang.Exception
    import java.lang.Runtime
    import java.lang.System
    import java.io.{File => JFile}
    import java.util.{Iterator => JIterator}
    import java.util.{Map => JMap}
    import java.util.{Set => JSet}
    import java.util.{Map$Entry => Entry}

    ///
    /// Returns the arguments passed to the program via the command line.
    ///
    pub def getArgs(): List[String] =
        unsafe Array.toList(unsafe Global.getArgs())

    ///
    /// Returns an map of the current system environment.
    ///
    pub def getEnv(): Map[String, String] =
        try {
            let iter = unsafe System.getenv().entrySet().iterator();
            getEnvHelper(iter, Map.empty())
        } catch {
            case _: Exception => Map.empty()
        }

    ///
    /// Returns the value of the specified environment variable.
    ///
    pub def getVar(name: String): Option[String] =
        try {
            let result = unsafe System.getenv(name);
            Object.toOption(result)
        } catch {
            case _: Exception => None
        }

    ///
    /// Returns the system property by name.
    ///
    pub def getProp(name: String): Option[String] =
        try {
            let result = unsafe System.getProperty(name);
            Object.toOption(result)
        } catch {
            case _: Exception => None
        }

    ///
    /// Returns the operating system name
    ///
    pub def getOsName(): Option[String] = getProp("os.name")

    ///
    ///  Returns the operating system architecture
    ///
    pub def getOsArch(): Option[String] = getProp("os.arch")

    ///
    ///  Returns the operating system version
    ///
    pub def getOsVersion(): Option[String] = getProp("os.version")

    ///
    ///  Returns the file separator
    ///
    pub def getFileSeparator(): String = unsafe JFile.separator

    ///
    /// Returns the path separator
    ///
    pub def getPathSeparator(): String = unsafe JFile.pathSeparator

    ///
    /// Returns the system line separator
    ///
    pub def getLineSeparator(): String =
        unsafe System.lineSeparator()

    ///
    /// Returns the user's current working directory
    ///
    pub def getCurrentWorkingDirectory(): Option[String] = getProp("user.dir")

    ///
    /// Returns the default temp file path
    ///
    pub def getTemporaryDirectory(): Option[String] = getProp("java.io.tmpdir")

    ///
    /// Returns the user's account name
    ///
    pub def getUserName(): Option[String] = getProp("user.name")

    ///
    /// Returns the user's home directory
    ///
    pub def getUserHomeDirectory(): Option[String] = getProp("user.home")

    ///
    /// Returns the number of virtual processors available to the JVM.
    ///
    /// The returned value is never less than one.
    ///
    pub def getVirtualProcessors(): Int32 =
        unsafe Runtime.getRuntime().availableProcessors()

    def getEnvHelper(iter: JIterator, m: Map[String, String]): Map[String, String] =
        if (unsafe iter.hasNext())
            let e = unsafe unchecked_cast(iter.next() as Entry);
            let k = unsafe unchecked_cast(e.getKey() as String);
            let v = unsafe unchecked_cast(e.getValue() as String);
            getEnvHelper(iter, Map.insert(k, v, m))
        else
            m

}
