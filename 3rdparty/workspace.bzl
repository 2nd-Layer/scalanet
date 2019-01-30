# Do not edit. bazel-deps autogenerates this file from dependencies.yaml.
def _jar_artifact_impl(ctx):
    jar_name = "%s.jar" % ctx.name
    ctx.download(
        output=ctx.path("jar/%s" % jar_name),
        url=ctx.attr.urls,
        sha256=ctx.attr.sha256,
        executable=False
    )
    src_name="%s-sources.jar" % ctx.name
    srcjar_attr=""
    has_sources = len(ctx.attr.src_urls) != 0
    if has_sources:
        ctx.download(
            output=ctx.path("jar/%s" % src_name),
            url=ctx.attr.src_urls,
            sha256=ctx.attr.src_sha256,
            executable=False
        )
        srcjar_attr ='\n    srcjar = ":%s",' % src_name

    build_file_contents = """
package(default_visibility = ['//visibility:public'])
java_import(
    name = 'jar',
    tags = ['maven_coordinates={artifact}'],
    jars = ['{jar_name}'],{srcjar_attr}
)
filegroup(
    name = 'file',
    srcs = [
        '{jar_name}',
        '{src_name}'
    ],
    visibility = ['//visibility:public']
)\n""".format(artifact = ctx.attr.artifact, jar_name = jar_name, src_name = src_name, srcjar_attr = srcjar_attr)
    ctx.file(ctx.path("jar/BUILD"), build_file_contents, False)
    return None

jar_artifact = repository_rule(
    attrs = {
        "artifact": attr.string(mandatory = True),
        "sha256": attr.string(mandatory = True),
        "urls": attr.string_list(mandatory = True),
        "src_sha256": attr.string(mandatory = False, default=""),
        "src_urls": attr.string_list(mandatory = False, default=[]),
    },
    implementation = _jar_artifact_impl
)

def jar_artifact_callback(hash):
    src_urls = []
    src_sha256 = ""
    source=hash.get("source", None)
    if source != None:
        src_urls = [source["url"]]
        src_sha256 = source["sha256"]
    jar_artifact(
        artifact = hash["artifact"],
        name = hash["name"],
        urls = [hash["url"]],
        sha256 = hash["sha256"],
        src_urls = src_urls,
        src_sha256 = src_sha256
    )
    native.bind(name = hash["bind"], actual = hash["actual"])


def list_dependencies():
    return [
    {"artifact": "com.beachape:enumeratum-macros_2.12:1.5.9", "lang": "scala", "sha1": "1a63056f0ba55a11c8d10150d27c247920e6c9c8", "sha256": "e7ef82aa1ab73d52cccfe78fa09d8491d021df153415cae6f5e60295a90ee187", "repository": "https://repo.maven.apache.org/maven2/", "url": "https://repo.maven.apache.org/maven2/com/beachape/enumeratum-macros_2.12/1.5.9/enumeratum-macros_2.12-1.5.9.jar", "source": {"sha1": "d4ea2d95cdbabc506913039463dfaac02bd8f866", "sha256": "8ce1a95fffb8d0a5eff3d4f30ec4cd653a4ad43ecbc28fa0caac9ab30ec47f61", "repository": "https://repo.maven.apache.org/maven2/", "url": "https://repo.maven.apache.org/maven2/com/beachape/enumeratum-macros_2.12/1.5.9/enumeratum-macros_2.12-1.5.9-sources.jar"} , "name": "com_beachape_enumeratum_macros_2_12", "actual": "@com_beachape_enumeratum_macros_2_12//jar:file", "bind": "jar/com/beachape/enumeratum_macros_2_12"},
    {"artifact": "com.beachape:enumeratum_2.12:1.5.13", "lang": "scala", "sha1": "f3cd444af103422b9baa0f81bf2f55d6e0378546", "sha256": "dbfdbacaa0a70d8080fc1ca5e2775b4be143678fa2ac47af0b6c7ac529f1d954", "repository": "https://repo.maven.apache.org/maven2/", "url": "https://repo.maven.apache.org/maven2/com/beachape/enumeratum_2.12/1.5.13/enumeratum_2.12-1.5.13.jar", "source": {"sha1": "b882b4108842e082c23d8423d599b59dbba90062", "sha256": "bc273aee4e92a72c6c6639dc6a30a632424bedf24fd8861f722ac32ca0c8aa4b", "repository": "https://repo.maven.apache.org/maven2/", "url": "https://repo.maven.apache.org/maven2/com/beachape/enumeratum_2.12/1.5.13/enumeratum_2.12-1.5.13-sources.jar"} , "name": "com_beachape_enumeratum_2_12", "actual": "@com_beachape_enumeratum_2_12//jar:file", "bind": "jar/com/beachape/enumeratum_2_12"},
    {"artifact": "com.chuusai:shapeless_2.12:2.3.3", "lang": "scala", "sha1": "6041e2c4871650c556a9c6842e43c04ed462b11f", "sha256": "312e301432375132ab49592bd8d22b9cd42a338a6300c6157fb4eafd1e3d5033", "repository": "https://repo.maven.apache.org/maven2/", "url": "https://repo.maven.apache.org/maven2/com/chuusai/shapeless_2.12/2.3.3/shapeless_2.12-2.3.3.jar", "source": {"sha1": "02511271188a92962fcf31a9a217b8122f75453a", "sha256": "2d53fea1b1ab224a4a731d99245747a640deaa6ef3912c253666aa61287f3d63", "repository": "https://repo.maven.apache.org/maven2/", "url": "https://repo.maven.apache.org/maven2/com/chuusai/shapeless_2.12/2.3.3/shapeless_2.12-2.3.3-sources.jar"} , "name": "com_chuusai_shapeless_2_12", "actual": "@com_chuusai_shapeless_2_12//jar:file", "bind": "jar/com/chuusai/shapeless_2_12"},
    {"artifact": "com.github.pureconfig:pureconfig-core_2.12:0.10.1", "lang": "scala", "sha1": "94521c090df2b635469a2ca5ba2b30c9478920ea", "sha256": "b287e21e6a879b9e675a2f720b5019ca9da64e835aa282197137164622f1eb55", "repository": "https://repo.maven.apache.org/maven2/", "url": "https://repo.maven.apache.org/maven2/com/github/pureconfig/pureconfig-core_2.12/0.10.1/pureconfig-core_2.12-0.10.1.jar", "source": {"sha1": "d314654d2e7b08e43503d16c715c2ae06323a995", "sha256": "93156c960a0c6bc75cc32fb86ca440cbc651e0e006b562589cd723c20dc77ea0", "repository": "https://repo.maven.apache.org/maven2/", "url": "https://repo.maven.apache.org/maven2/com/github/pureconfig/pureconfig-core_2.12/0.10.1/pureconfig-core_2.12-0.10.1-sources.jar"} , "name": "com_github_pureconfig_pureconfig_core_2_12", "actual": "@com_github_pureconfig_pureconfig_core_2_12//jar:file", "bind": "jar/com/github/pureconfig/pureconfig_core_2_12"},
    {"artifact": "com.github.pureconfig:pureconfig-generic_2.12:0.10.1", "lang": "scala", "sha1": "0bbbdee9f88161598660b127460a4d0b78297464", "sha256": "357f143df315d4baf5be4e32cdfcb03866042f92188bbb3b294b489014ba9f2f", "repository": "https://repo.maven.apache.org/maven2/", "url": "https://repo.maven.apache.org/maven2/com/github/pureconfig/pureconfig-generic_2.12/0.10.1/pureconfig-generic_2.12-0.10.1.jar", "source": {"sha1": "bb3e5fd5c390ede68159ae655c31a8366d01ca83", "sha256": "b8d779bb86eabb8e3c3c32e31cf4a13ee64c8baa92bbd2d98623770f8e8b71c1", "repository": "https://repo.maven.apache.org/maven2/", "url": "https://repo.maven.apache.org/maven2/com/github/pureconfig/pureconfig-generic_2.12/0.10.1/pureconfig-generic_2.12-0.10.1-sources.jar"} , "name": "com_github_pureconfig_pureconfig_generic_2_12", "actual": "@com_github_pureconfig_pureconfig_generic_2_12//jar:file", "bind": "jar/com/github/pureconfig/pureconfig_generic_2_12"},
    {"artifact": "com.github.pureconfig:pureconfig-macros_2.12:0.10.1", "lang": "scala", "sha1": "6417dd8d75e0d5cc1b3f738938d6f0b60673dcf2", "sha256": "6ecfbb5e3c10c539d3b906bc3d8104ea847a03c6069c0b732cbcd2b0796bccfd", "repository": "https://repo.maven.apache.org/maven2/", "url": "https://repo.maven.apache.org/maven2/com/github/pureconfig/pureconfig-macros_2.12/0.10.1/pureconfig-macros_2.12-0.10.1.jar", "source": {"sha1": "675937e081081aaf2285c0a5a1065590a86522d1", "sha256": "e2847441a61c9b2f6994ee23e0d9d08d7d1fe0fede1c4f6a365ba0b747d6cc31", "repository": "https://repo.maven.apache.org/maven2/", "url": "https://repo.maven.apache.org/maven2/com/github/pureconfig/pureconfig-macros_2.12/0.10.1/pureconfig-macros_2.12-0.10.1-sources.jar"} , "name": "com_github_pureconfig_pureconfig_macros_2_12", "actual": "@com_github_pureconfig_pureconfig_macros_2_12//jar:file", "bind": "jar/com/github/pureconfig/pureconfig_macros_2_12"},
    {"artifact": "com.github.pureconfig:pureconfig_2.12:0.10.1", "lang": "scala", "sha1": "a03a6d959ee9d1a762c8aa68baa5c2e1671aa34a", "sha256": "cf4ba55a25a453eebff8671a7527012a5125daa902dd90cf6c8e4e2b9c108f8a", "repository": "https://repo.maven.apache.org/maven2/", "url": "https://repo.maven.apache.org/maven2/com/github/pureconfig/pureconfig_2.12/0.10.1/pureconfig_2.12-0.10.1.jar", "source": {"sha1": "d6e644636b4eb93daec5826e650b6c26bc7ce984", "sha256": "6f5ef5b8b1d7d4ed2286db88474872424c118ff574921531fdae128ee67d8ec9", "repository": "https://repo.maven.apache.org/maven2/", "url": "https://repo.maven.apache.org/maven2/com/github/pureconfig/pureconfig_2.12/0.10.1/pureconfig_2.12-0.10.1-sources.jar"} , "name": "com_github_pureconfig_pureconfig_2_12", "actual": "@com_github_pureconfig_pureconfig_2_12//jar:file", "bind": "jar/com/github/pureconfig/pureconfig_2_12"},
    {"artifact": "com.netflix.spectator:spectator-api:0.57.1", "lang": "java", "sha1": "2b9d5d2735d6422ae49d6270bdcd63f373996026", "sha256": "e0485838ca905a7af953c75d32b5d950292200134ba6fbe146f9f97ee19c6461", "repository": "https://repo.maven.apache.org/maven2/", "url": "https://repo.maven.apache.org/maven2/com/netflix/spectator/spectator-api/0.57.1/spectator-api-0.57.1.jar", "source": {"sha1": "148faf7287a829dd4de310565acf05e64a0c1f28", "sha256": "98ac182e7d07b4898fae3e7e12febd1b87c7d4a4c6f1bca2baf94215265c3119", "repository": "https://repo.maven.apache.org/maven2/", "url": "https://repo.maven.apache.org/maven2/com/netflix/spectator/spectator-api/0.57.1/spectator-api-0.57.1-sources.jar"} , "name": "com_netflix_spectator_spectator_api", "actual": "@com_netflix_spectator_spectator_api//jar", "bind": "jar/com/netflix/spectator/spectator_api"},
    {"artifact": "com.softwaremill.quicklens:quicklens_2.12:1.4.11", "lang": "scala", "sha1": "89e9ca901795e349f69fa2955919860f76cbe954", "sha256": "e45f063319ac87c2b73552ca38e6db495e01232408c5598aae73a4a2fc19735d", "repository": "https://repo.maven.apache.org/maven2/", "url": "https://repo.maven.apache.org/maven2/com/softwaremill/quicklens/quicklens_2.12/1.4.11/quicklens_2.12-1.4.11.jar", "source": {"sha1": "ee69f3904d679d1340b8f081fe8373fac4842b53", "sha256": "46555433655c6ce1a64db932c8db6f11ef72cf5f986aac81ff977f5bd5484c3e", "repository": "https://repo.maven.apache.org/maven2/", "url": "https://repo.maven.apache.org/maven2/com/softwaremill/quicklens/quicklens_2.12/1.4.11/quicklens_2.12-1.4.11-sources.jar"} , "name": "com_softwaremill_quicklens_quicklens_2_12", "actual": "@com_softwaremill_quicklens_quicklens_2_12//jar:file", "bind": "jar/com/softwaremill/quicklens/quicklens_2_12"},
    {"artifact": "com.typesafe.akka:akka-actor-testkit-typed_2.12:2.5.19", "lang": "scala", "sha1": "98a7b39c6c183a964d0c2a02936ce17febe55c5e", "sha256": "e360cc7ca676f35adc6f38e17376f21e748d935a4e5fa4faa22961416850df66", "repository": "https://repo.maven.apache.org/maven2/", "url": "https://repo.maven.apache.org/maven2/com/typesafe/akka/akka-actor-testkit-typed_2.12/2.5.19/akka-actor-testkit-typed_2.12-2.5.19.jar", "source": {"sha1": "86e57c3f4516cbec034a95b212cac938b8749b8b", "sha256": "34042ef8d665eb04d1280f14d1c8c02f0afc30636f8eef0bdd9c0358007e38e4", "repository": "https://repo.maven.apache.org/maven2/", "url": "https://repo.maven.apache.org/maven2/com/typesafe/akka/akka-actor-testkit-typed_2.12/2.5.19/akka-actor-testkit-typed_2.12-2.5.19-sources.jar"} , "name": "com_typesafe_akka_akka_actor_testkit_typed_2_12", "actual": "@com_typesafe_akka_akka_actor_testkit_typed_2_12//jar:file", "bind": "jar/com/typesafe/akka/akka_actor_testkit_typed_2_12"},
    {"artifact": "com.typesafe.akka:akka-actor-typed_2.12:2.5.19", "lang": "scala", "sha1": "51362180a4659548c0c3349ef22118432ef2c638", "sha256": "63a5e79925afce40dd4432b25c2bb7ce6bc1003c4128017b33abe80b6f919a55", "repository": "https://repo.maven.apache.org/maven2/", "url": "https://repo.maven.apache.org/maven2/com/typesafe/akka/akka-actor-typed_2.12/2.5.19/akka-actor-typed_2.12-2.5.19.jar", "source": {"sha1": "97a4742c70a007077c1a7dfed8a33e79285cd6f8", "sha256": "a14e5a30bafd79f5ab0460c42e4218828fa25b83850a0c4756a384ab6792e401", "repository": "https://repo.maven.apache.org/maven2/", "url": "https://repo.maven.apache.org/maven2/com/typesafe/akka/akka-actor-typed_2.12/2.5.19/akka-actor-typed_2.12-2.5.19-sources.jar"} , "name": "com_typesafe_akka_akka_actor_typed_2_12", "actual": "@com_typesafe_akka_akka_actor_typed_2_12//jar:file", "bind": "jar/com/typesafe/akka/akka_actor_typed_2_12"},
    {"artifact": "com.typesafe.akka:akka-actor_2.12:2.5.19", "lang": "scala", "sha1": "24707fdb38b1d8e74ccfe816f9fa145cf8c097e3", "sha256": "33b5eef9db3766a7e7a307457995fde116967ead482c88377b2466475d8f703b", "repository": "https://repo.maven.apache.org/maven2/", "url": "https://repo.maven.apache.org/maven2/com/typesafe/akka/akka-actor_2.12/2.5.19/akka-actor_2.12-2.5.19.jar", "source": {"sha1": "c082477c7efba8de52d95ccdc7cedb6c680bf3af", "sha256": "5f4a9a2b8e8f258de65c7b7beeaf5814e7b946e2a82d947c2de3ef9f15f55ea5", "repository": "https://repo.maven.apache.org/maven2/", "url": "https://repo.maven.apache.org/maven2/com/typesafe/akka/akka-actor_2.12/2.5.19/akka-actor_2.12-2.5.19-sources.jar"} , "name": "com_typesafe_akka_akka_actor_2_12", "actual": "@com_typesafe_akka_akka_actor_2_12//jar:file", "bind": "jar/com/typesafe/akka/akka_actor_2_12"},
    {"artifact": "com.typesafe.akka:akka-slf4j_2.12:2.5.19", "lang": "scala", "sha1": "6b31e643fa4f20a90562ab6f800bd15db1539719", "sha256": "2676e9d6e9f3b712a49db3df0a8c3b0db3dc89c8846295d12c3cf274c8cde6dd", "repository": "https://repo.maven.apache.org/maven2/", "url": "https://repo.maven.apache.org/maven2/com/typesafe/akka/akka-slf4j_2.12/2.5.19/akka-slf4j_2.12-2.5.19.jar", "source": {"sha1": "3d4dcc51291c5335dc4246596048a83ff6a9e34a", "sha256": "9c3f15703c2179442c876b50578711607afdc05715d983acca36b8939c534880", "repository": "https://repo.maven.apache.org/maven2/", "url": "https://repo.maven.apache.org/maven2/com/typesafe/akka/akka-slf4j_2.12/2.5.19/akka-slf4j_2.12-2.5.19-sources.jar"} , "name": "com_typesafe_akka_akka_slf4j_2_12", "actual": "@com_typesafe_akka_akka_slf4j_2_12//jar:file", "bind": "jar/com/typesafe/akka/akka_slf4j_2_12"},
    {"artifact": "com.typesafe.akka:akka-testkit_2.12:2.5.19", "lang": "scala", "sha1": "1081ace119aa1a0ab7718d38ed838b050fc777f5", "sha256": "33a87b84b6bf886863800c546a22452cd88782dbf5b7cf536710c709108063a4", "repository": "https://repo.maven.apache.org/maven2/", "url": "https://repo.maven.apache.org/maven2/com/typesafe/akka/akka-testkit_2.12/2.5.19/akka-testkit_2.12-2.5.19.jar", "source": {"sha1": "776236d7b5e56d2a2b9d19d7312c54ce0a6a3474", "sha256": "24709101933e191b9af3885871cc5996add4afa197d8203912dc51b9cd1d039d", "repository": "https://repo.maven.apache.org/maven2/", "url": "https://repo.maven.apache.org/maven2/com/typesafe/akka/akka-testkit_2.12/2.5.19/akka-testkit_2.12-2.5.19-sources.jar"} , "name": "com_typesafe_akka_akka_testkit_2_12", "actual": "@com_typesafe_akka_akka_testkit_2_12//jar:file", "bind": "jar/com/typesafe/akka/akka_testkit_2_12"},
    {"artifact": "com.typesafe:config:1.3.3", "lang": "java", "sha1": "4b68c2d5d0403bb4015520fcfabc88d0cbc4d117", "sha256": "b5f1d6071f1548d05be82f59f9039c7d37a1787bd8e3c677e31ee275af4a4621", "repository": "https://repo.maven.apache.org/maven2/", "url": "https://repo.maven.apache.org/maven2/com/typesafe/config/1.3.3/config-1.3.3.jar", "source": {"sha1": "c7af5bd41815a5edc8e7a81082e88fe18f9729e0", "sha256": "fcd7c3070417c776b313cc559665c035d74e3a2b40a89bbb0e9bff6e567c9cc8", "repository": "https://repo.maven.apache.org/maven2/", "url": "https://repo.maven.apache.org/maven2/com/typesafe/config/1.3.3/config-1.3.3-sources.jar"} , "name": "com_typesafe_config", "actual": "@com_typesafe_config//jar", "bind": "jar/com/typesafe/config"},
    {"artifact": "io.micrometer:micrometer-core:0.12.0.RELEASE", "lang": "java", "sha1": "70f5fc79943d93fcfcb7e1576df7574537bc0004", "sha256": "fdf9571581731fc20b6dc44742d51ec1aa0ce0c6ef964522dd2a7a9e2fbd2dff", "repository": "https://repo.maven.apache.org/maven2/", "url": "https://repo.maven.apache.org/maven2/io/micrometer/micrometer-core/0.12.0.RELEASE/micrometer-core-0.12.0.RELEASE.jar", "source": {"sha1": "aa3ddc567858e82b59d8d3050f787019e8092da3", "sha256": "30b86c862544121152b2ad9f00f49b2437577211be35aab44ac085a26f77f6b0", "repository": "https://repo.maven.apache.org/maven2/", "url": "https://repo.maven.apache.org/maven2/io/micrometer/micrometer-core/0.12.0.RELEASE/micrometer-core-0.12.0.RELEASE-sources.jar"} , "name": "io_micrometer_micrometer_core", "actual": "@io_micrometer_micrometer_core//jar", "bind": "jar/io/micrometer/micrometer_core"},
    {"artifact": "io.micrometer:micrometer-registry-datadog:0.12.0.RELEASE", "lang": "java", "sha1": "41d390d942a830efd701d5784a114769ded5ae0a", "sha256": "a001e49795f90b949af1aa45881550fe59cf9f702215d8b170dad810f06ba71d", "repository": "https://repo.maven.apache.org/maven2/", "url": "https://repo.maven.apache.org/maven2/io/micrometer/micrometer-registry-datadog/0.12.0.RELEASE/micrometer-registry-datadog-0.12.0.RELEASE.jar", "source": {"sha1": "657697a5dd07c91ac414b8145f9646a7ce45ef72", "sha256": "ca14c76e4750fdbaeafb3baaf50ef3669de90221618d98aef7bef9c6d01a5305", "repository": "https://repo.maven.apache.org/maven2/", "url": "https://repo.maven.apache.org/maven2/io/micrometer/micrometer-registry-datadog/0.12.0.RELEASE/micrometer-registry-datadog-0.12.0.RELEASE-sources.jar"} , "name": "io_micrometer_micrometer_registry_datadog", "actual": "@io_micrometer_micrometer_registry_datadog//jar", "bind": "jar/io/micrometer/micrometer_registry_datadog"},
    {"artifact": "io.monix:monix-eval_2.12:3.0.0-RC1", "lang": "scala", "sha1": "093f340f8b3c70e53ed10820e9bc637a884ef2d5", "sha256": "69bd5b4eacf30af9c50f2e1e89b8282586ddefb176df655288901872f9eee2e5", "repository": "https://repo.maven.apache.org/maven2/", "url": "https://repo.maven.apache.org/maven2/io/monix/monix-eval_2.12/3.0.0-RC1/monix-eval_2.12-3.0.0-RC1.jar", "source": {"sha1": "a673c9fa8c405af301e42a7cc8d31d187e8ac738", "sha256": "45565f6dfd91eeb36d410e2ca8537223c05d3f94a058689411f16b9f274d321b", "repository": "https://repo.maven.apache.org/maven2/", "url": "https://repo.maven.apache.org/maven2/io/monix/monix-eval_2.12/3.0.0-RC1/monix-eval_2.12-3.0.0-RC1-sources.jar"} , "name": "io_monix_monix_eval_2_12", "actual": "@io_monix_monix_eval_2_12//jar:file", "bind": "jar/io/monix/monix_eval_2_12"},
    {"artifact": "io.monix:monix-execution_2.12:3.0.0-RC1", "lang": "scala", "sha1": "c35e304152b7f2fa57575452601fa81dab90b657", "sha256": "5d72108ea78666ea806d13ffb69e70c9b0e5ed3b4434d41022ee2f983f7ff6f8", "repository": "https://repo.maven.apache.org/maven2/", "url": "https://repo.maven.apache.org/maven2/io/monix/monix-execution_2.12/3.0.0-RC1/monix-execution_2.12-3.0.0-RC1.jar", "source": {"sha1": "c393d03d26ca4d3d1c5340782a2f7b09e1a7f5d4", "sha256": "f59c48f3c29ef0e07f5eeed044337989c910d286ccb8e1c8e23f067975532103", "repository": "https://repo.maven.apache.org/maven2/", "url": "https://repo.maven.apache.org/maven2/io/monix/monix-execution_2.12/3.0.0-RC1/monix-execution_2.12-3.0.0-RC1-sources.jar"} , "name": "io_monix_monix_execution_2_12", "actual": "@io_monix_monix_execution_2_12//jar:file", "bind": "jar/io/monix/monix_execution_2_12"},
    {"artifact": "io.monix:monix-java_2.12:3.0.0-RC1", "lang": "scala", "sha1": "f1f80eaf501f2122809dad987c7e6dfc9dc3deff", "sha256": "58f19b051f1e1c4b6825f9213e0a09949f2dbc0a0d1b44af912b830e720ad146", "repository": "https://repo.maven.apache.org/maven2/", "url": "https://repo.maven.apache.org/maven2/io/monix/monix-java_2.12/3.0.0-RC1/monix-java_2.12-3.0.0-RC1.jar", "source": {"sha1": "f27c3876eb77414c3fc45a66e6b4164ef891de25", "sha256": "b72026b7c2eff6d09fdf314b6c267ef447c005e14a349237605d019e85f9250c", "repository": "https://repo.maven.apache.org/maven2/", "url": "https://repo.maven.apache.org/maven2/io/monix/monix-java_2.12/3.0.0-RC1/monix-java_2.12-3.0.0-RC1-sources.jar"} , "name": "io_monix_monix_java_2_12", "actual": "@io_monix_monix_java_2_12//jar:file", "bind": "jar/io/monix/monix_java_2_12"},
    {"artifact": "io.monix:monix-reactive_2.12:3.0.0-RC1", "lang": "scala", "sha1": "1f507913d48a8273b835e5a2a679a5d1e80153db", "sha256": "3024a78ab57e293e965a695cf70c584e6dbffde79f1b1d19d6490c3301b6d7e4", "repository": "https://repo.maven.apache.org/maven2/", "url": "https://repo.maven.apache.org/maven2/io/monix/monix-reactive_2.12/3.0.0-RC1/monix-reactive_2.12-3.0.0-RC1.jar", "source": {"sha1": "695197219aa8d4caa9c90a8167ef547719a93a2e", "sha256": "7537014b3cd8061b0031b01208025acc164d6f4a8cdf735ec2bd3edbd0023eb6", "repository": "https://repo.maven.apache.org/maven2/", "url": "https://repo.maven.apache.org/maven2/io/monix/monix-reactive_2.12/3.0.0-RC1/monix-reactive_2.12-3.0.0-RC1-sources.jar"} , "name": "io_monix_monix_reactive_2_12", "actual": "@io_monix_monix_reactive_2_12//jar:file", "bind": "jar/io/monix/monix_reactive_2_12"},
    {"artifact": "io.monix:monix-tail_2.12:3.0.0-RC1", "lang": "scala", "sha1": "598d24fd7cbb00d421e9217a0869438f34cf51c9", "sha256": "7cd7d22334744de3002870d3f1ff0204f96b4abb1469cfa84e9e98631b8f42dd", "repository": "https://repo.maven.apache.org/maven2/", "url": "https://repo.maven.apache.org/maven2/io/monix/monix-tail_2.12/3.0.0-RC1/monix-tail_2.12-3.0.0-RC1.jar", "source": {"sha1": "8580759446b05cffc69a274314248c87f5046c66", "sha256": "185fc0e3ed2b4da9f80b0ce873f44458ffff157caf9e18d32b71e7573510ed7a", "repository": "https://repo.maven.apache.org/maven2/", "url": "https://repo.maven.apache.org/maven2/io/monix/monix-tail_2.12/3.0.0-RC1/monix-tail_2.12-3.0.0-RC1-sources.jar"} , "name": "io_monix_monix_tail_2_12", "actual": "@io_monix_monix_tail_2_12//jar:file", "bind": "jar/io/monix/monix_tail_2_12"},
    {"artifact": "io.monix:monix_2.12:3.0.0-RC1", "lang": "scala", "sha1": "e252ab4de5ba4bb1afbde3103739e8750f620311", "sha256": "ce248d75d6a269d4a0434e8d9918cef870f3d3958d56f1c921f70918a41616a3", "repository": "https://repo.maven.apache.org/maven2/", "url": "https://repo.maven.apache.org/maven2/io/monix/monix_2.12/3.0.0-RC1/monix_2.12-3.0.0-RC1.jar", "source": {"sha1": "bff373f8e42eead9add56536e53feac6256159f6", "sha256": "10f8af2bd04c84e5d4650caa49f1a6c6cf0ae6c123e1276c22196f124e74f92d", "repository": "https://repo.maven.apache.org/maven2/", "url": "https://repo.maven.apache.org/maven2/io/monix/monix_2.12/3.0.0-RC1/monix_2.12-3.0.0-RC1-sources.jar"} , "name": "io_monix_monix_2_12", "actual": "@io_monix_monix_2_12//jar:file", "bind": "jar/io/monix/monix_2_12"},
    {"artifact": "io.netty:netty-all:4.1.28.Final", "lang": "java", "sha1": "33ae3d109e16b8c591bdf343f6b52ccd0ef75905", "sha256": "375036f44a72a99b73aac3997b77229270c80f6531f2fea84bd869178c6ea203", "repository": "https://repo.maven.apache.org/maven2/", "url": "https://repo.maven.apache.org/maven2/io/netty/netty-all/4.1.28.Final/netty-all-4.1.28.Final.jar", "source": {"sha1": "eb551d5ad67954f637cffcc010fbd0a913089188", "sha256": "ad93898f4bdb6800c8f8e1fae2e36f84ee5a3637b990e527d677c54f74d016b3", "repository": "https://repo.maven.apache.org/maven2/", "url": "https://repo.maven.apache.org/maven2/io/netty/netty-all/4.1.28.Final/netty-all-4.1.28.Final-sources.jar"} , "name": "io_netty_netty_all", "actual": "@io_netty_netty_all//jar", "bind": "jar/io/netty/netty_all"},
    {"artifact": "net.bytebuddy:byte-buddy-agent:1.8.15", "lang": "java", "sha1": "a2dbe3457401f65ad4022617fbb3fc0e5f427c7d", "sha256": "ca741271f1dc60557dd455f4d1f0363e8840612f6f08b5641342d84c07f14703", "repository": "https://repo.maven.apache.org/maven2/", "url": "https://repo.maven.apache.org/maven2/net/bytebuddy/byte-buddy-agent/1.8.15/byte-buddy-agent-1.8.15.jar", "source": {"sha1": "7bd145597e02bf07eea8cff4a3d8e0bdbe66d21f", "sha256": "8d42067e2111943eb8b873320a394d2ef760b88d7fc235942c01d384924d289c", "repository": "https://repo.maven.apache.org/maven2/", "url": "https://repo.maven.apache.org/maven2/net/bytebuddy/byte-buddy-agent/1.8.15/byte-buddy-agent-1.8.15-sources.jar"} , "name": "net_bytebuddy_byte_buddy_agent", "actual": "@net_bytebuddy_byte_buddy_agent//jar", "bind": "jar/net/bytebuddy/byte_buddy_agent"},
    {"artifact": "net.bytebuddy:byte-buddy:1.8.15", "lang": "java", "sha1": "cb36fe3c70ead5fcd016856a7efff908402d86b8", "sha256": "af32e420b1252c1eedef6232bd46fadafc02e0c609e086efd57a64781107a039", "repository": "https://repo.maven.apache.org/maven2/", "url": "https://repo.maven.apache.org/maven2/net/bytebuddy/byte-buddy/1.8.15/byte-buddy-1.8.15.jar", "source": {"sha1": "a8f95953d78effdd8eca80e92c5b62f648b4a1f5", "sha256": "c18794f50d1dfc8fb57bfd886b566b05697da396022bcd63b5463a454d33c899", "repository": "https://repo.maven.apache.org/maven2/", "url": "https://repo.maven.apache.org/maven2/net/bytebuddy/byte-buddy/1.8.15/byte-buddy-1.8.15-sources.jar"} , "name": "net_bytebuddy_byte_buddy", "actual": "@net_bytebuddy_byte_buddy//jar", "bind": "jar/net/bytebuddy/byte_buddy"},
    {"artifact": "org.bouncycastle:bcprov-jdk15on:1.59", "lang": "java", "sha1": "2507204241ab450456bdb8e8c0a8f986e418bd99", "sha256": "1c31e44e331d25e46d293b3e8ee2d07028a67db011e74cb2443285aed1d59c85", "repository": "https://repo.maven.apache.org/maven2/", "url": "https://repo.maven.apache.org/maven2/org/bouncycastle/bcprov-jdk15on/1.59/bcprov-jdk15on-1.59.jar", "source": {"sha1": "85a78cf9aa7020b89cd8c14daf4b7d2a397abe91", "sha256": "1f5c5264bf39fdc96608acbc3cc35647b806125595c3ce6ec22c4acf13e099a4", "repository": "https://repo.maven.apache.org/maven2/", "url": "https://repo.maven.apache.org/maven2/org/bouncycastle/bcprov-jdk15on/1.59/bcprov-jdk15on-1.59-sources.jar"} , "name": "org_bouncycastle_bcprov_jdk15on", "actual": "@org_bouncycastle_bcprov_jdk15on//jar", "bind": "jar/org/bouncycastle/bcprov_jdk15on"},
    {"artifact": "org.jctools:jctools-core:2.1.1", "lang": "java", "sha1": "9a1a7e006fb11f64716694c30de243fdf973c62f", "sha256": "21d1f6c06bca41fc8ededed6dbc7972cff668299f1e4c79ca62a9cb39f2fb4f8", "repository": "https://repo.maven.apache.org/maven2/", "url": "https://repo.maven.apache.org/maven2/org/jctools/jctools-core/2.1.1/jctools-core-2.1.1.jar", "source": {"sha1": "ce302ce6fd1a195b46e53284287330ad8a1f399a", "sha256": "687843a61b6bd5160a3a1cabb29b42181d565e445a902832c8ca23026b48a0b9", "repository": "https://repo.maven.apache.org/maven2/", "url": "https://repo.maven.apache.org/maven2/org/jctools/jctools-core/2.1.1/jctools-core-2.1.1-sources.jar"} , "name": "org_jctools_jctools_core", "actual": "@org_jctools_jctools_core//jar", "bind": "jar/org/jctools/jctools_core"},
    {"artifact": "org.mockito:mockito-core:2.21.0", "lang": "java", "sha1": "cdd1d0d5b2edbd2a7040735ccf88318c031f458b", "sha256": "976353102556c5654361dccf6211c7a9de9942fabe94620aa5a1d68be6997b79", "repository": "https://repo.maven.apache.org/maven2/", "url": "https://repo.maven.apache.org/maven2/org/mockito/mockito-core/2.21.0/mockito-core-2.21.0.jar", "source": {"sha1": "6ce1c9a7dc4e816d309abb74f0c032bd3c9b59f6", "sha256": "955e885c048d65b5ad5dfdd36fff4aab48f7911a3627e75c3a47182d608a4a43", "repository": "https://repo.maven.apache.org/maven2/", "url": "https://repo.maven.apache.org/maven2/org/mockito/mockito-core/2.21.0/mockito-core-2.21.0-sources.jar"} , "name": "org_mockito_mockito_core", "actual": "@org_mockito_mockito_core//jar", "bind": "jar/org/mockito/mockito_core"},
    {"artifact": "org.objenesis:objenesis:2.6", "lang": "java", "sha1": "639033469776fd37c08358c6b92a4761feb2af4b", "sha256": "5e168368fbc250af3c79aa5fef0c3467a2d64e5a7bd74005f25d8399aeb0708d", "repository": "https://repo.maven.apache.org/maven2/", "url": "https://repo.maven.apache.org/maven2/org/objenesis/objenesis/2.6/objenesis-2.6.jar", "source": {"sha1": "96614f514a1031296657bf0dde452dc15e42fcb8", "sha256": "52d9f4dba531677fc074eff00ea07f22a1d42e5a97cc9e8571c4cd3d459b6be0", "repository": "https://repo.maven.apache.org/maven2/", "url": "https://repo.maven.apache.org/maven2/org/objenesis/objenesis/2.6/objenesis-2.6-sources.jar"} , "name": "org_objenesis_objenesis", "actual": "@org_objenesis_objenesis//jar", "bind": "jar/org/objenesis/objenesis"},
    {"artifact": "org.reactivestreams:reactive-streams:1.0.2", "lang": "java", "sha1": "323964c36556eb0e6209f65c1cef72b53b461ab8", "sha256": "cc09ab0b140e0d0496c2165d4b32ce24f4d6446c0a26c5dc77b06bdf99ee8fae", "repository": "https://repo.maven.apache.org/maven2/", "url": "https://repo.maven.apache.org/maven2/org/reactivestreams/reactive-streams/1.0.2/reactive-streams-1.0.2.jar", "source": {"sha1": "fb592a3d57b11e71eb7a6211dd12ba824c5dd037", "sha256": "963a6480f46a64013d0f144ba41c6c6e63c4d34b655761717a436492886f3667", "repository": "https://repo.maven.apache.org/maven2/", "url": "https://repo.maven.apache.org/maven2/org/reactivestreams/reactive-streams/1.0.2/reactive-streams-1.0.2-sources.jar"} , "name": "org_reactivestreams_reactive_streams", "actual": "@org_reactivestreams_reactive_streams//jar", "bind": "jar/org/reactivestreams/reactive_streams"},
    {"artifact": "org.scala-lang.modules:scala-java8-compat_2.12:0.8.0", "lang": "scala", "sha1": "1e6f1e745bf6d3c34d1e2ab150653306069aaf34", "sha256": "d9d5dfd1bc49a8158e6e0a90b2ed08fa602984d815c00af16cec53557e83ef8e", "repository": "https://repo.maven.apache.org/maven2/", "url": "https://repo.maven.apache.org/maven2/org/scala-lang/modules/scala-java8-compat_2.12/0.8.0/scala-java8-compat_2.12-0.8.0.jar", "source": {"sha1": "0a33ce48278b9e3bbea8aed726e3c0abad3afadd", "sha256": "c0926003987a5c21108748fda401023485085eaa9fe90a41a40bcf67596fff34", "repository": "https://repo.maven.apache.org/maven2/", "url": "https://repo.maven.apache.org/maven2/org/scala-lang/modules/scala-java8-compat_2.12/0.8.0/scala-java8-compat_2.12-0.8.0-sources.jar"} , "name": "org_scala_lang_modules_scala_java8_compat_2_12", "actual": "@org_scala_lang_modules_scala_java8_compat_2_12//jar:file", "bind": "jar/org/scala_lang/modules/scala_java8_compat_2_12"},
    {"artifact": "org.scala-sbt:test-interface:1.0", "lang": "java", "sha1": "0a3f14d010c4cb32071f863d97291df31603b521", "sha256": "15f70b38bb95f3002fec9aea54030f19bb4ecfbad64c67424b5e5fea09cd749e", "repository": "https://repo.maven.apache.org/maven2/", "url": "https://repo.maven.apache.org/maven2/org/scala-sbt/test-interface/1.0/test-interface-1.0.jar", "source": {"sha1": "d44b23e9e3419ad0e00b91bba764a48d43075000", "sha256": "c314491c9df4f0bd9dd125ef1d51228d70bd466ee57848df1cd1b96aea18a5ad", "repository": "https://repo.maven.apache.org/maven2/", "url": "https://repo.maven.apache.org/maven2/org/scala-sbt/test-interface/1.0/test-interface-1.0-sources.jar"} , "name": "org_scala_sbt_test_interface", "actual": "@org_scala_sbt_test_interface//jar", "bind": "jar/org/scala_sbt/test_interface"},
    {"artifact": "org.scalacheck:scalacheck_2.12:1.14.0", "lang": "scala", "sha1": "8b4354c1a5e1799b4b0ab888d326e7f7fdb02d0d", "sha256": "1e6f5b292bb74b03be74195047816632b7d95e40e7f9c13d5d2c53bafeece62e", "repository": "https://repo.maven.apache.org/maven2/", "url": "https://repo.maven.apache.org/maven2/org/scalacheck/scalacheck_2.12/1.14.0/scalacheck_2.12-1.14.0.jar", "source": {"sha1": "ee64746db17b19449fae7e4b9f9ffc8fb7e79d80", "sha256": "6d51786f6ed8241bc02ea90bdd769ef16f2cc034624e06877de1d4a735efcb7f", "repository": "https://repo.maven.apache.org/maven2/", "url": "https://repo.maven.apache.org/maven2/org/scalacheck/scalacheck_2.12/1.14.0/scalacheck_2.12-1.14.0-sources.jar"} , "name": "org_scalacheck_scalacheck_2_12", "actual": "@org_scalacheck_scalacheck_2_12//jar:file", "bind": "jar/org/scalacheck/scalacheck_2_12"},
    {"artifact": "org.scalactic:scalactic_2.12:3.0.5", "lang": "scala", "sha1": "edec43902cdc7c753001501e0d8c2de78394fb03", "sha256": "57e25b4fd969b1758fe042595112c874dfea99dca5cc48eebe07ac38772a0c41", "repository": "https://repo.maven.apache.org/maven2/", "url": "https://repo.maven.apache.org/maven2/org/scalactic/scalactic_2.12/3.0.5/scalactic_2.12-3.0.5.jar", "source": {"sha1": "e02d37e95ba74c95aa9063b9114db51f2810b212", "sha256": "0455eaecaa2b8ce0be537120c2ccd407c4606cbe53e63cb6a7fc8b31b5b65461", "repository": "https://repo.maven.apache.org/maven2/", "url": "https://repo.maven.apache.org/maven2/org/scalactic/scalactic_2.12/3.0.5/scalactic_2.12-3.0.5-sources.jar"} , "name": "org_scalactic_scalactic_2_12", "actual": "@org_scalactic_scalactic_2_12//jar:file", "bind": "jar/org/scalactic/scalactic_2_12"},
    {"artifact": "org.scalatest:scalatest_2.12:3.0.5", "lang": "scala", "sha1": "7bb56c0f7a3c60c465e36c6b8022a95b883d7434", "sha256": "b416b5bcef6720da469a8d8a5726e457fc2d1cd5d316e1bc283aa75a2ae005e5", "repository": "https://repo.maven.apache.org/maven2/", "url": "https://repo.maven.apache.org/maven2/org/scalatest/scalatest_2.12/3.0.5/scalatest_2.12-3.0.5.jar", "source": {"sha1": "ec414035204524d3d4205ef572075e34a2078c78", "sha256": "22081ee83810098adc9af4d84d05dd5891d7c0e15f9095bcdaf4ac7a228b92df", "repository": "https://repo.maven.apache.org/maven2/", "url": "https://repo.maven.apache.org/maven2/org/scalatest/scalatest_2.12/3.0.5/scalatest_2.12-3.0.5-sources.jar"} , "name": "org_scalatest_scalatest_2_12", "actual": "@org_scalatest_scalatest_2_12//jar:file", "bind": "jar/org/scalatest/scalatest_2_12"},
    {"artifact": "org.slf4j:slf4j-api:1.7.25", "lang": "java", "sha1": "da76ca59f6a57ee3102f8f9bd9cee742973efa8a", "sha256": "18c4a0095d5c1da6b817592e767bb23d29dd2f560ad74df75ff3961dbde25b79", "repository": "https://repo.maven.apache.org/maven2/", "url": "https://repo.maven.apache.org/maven2/org/slf4j/slf4j-api/1.7.25/slf4j-api-1.7.25.jar", "source": {"sha1": "962153db4a9ea71b79d047dfd1b2a0d80d8f4739", "sha256": "c4bc93180a4f0aceec3b057a2514abe04a79f06c174bbed910a2afb227b79366", "repository": "https://repo.maven.apache.org/maven2/", "url": "https://repo.maven.apache.org/maven2/org/slf4j/slf4j-api/1.7.25/slf4j-api-1.7.25-sources.jar"} , "name": "org_slf4j_slf4j_api", "actual": "@org_slf4j_slf4j_api//jar", "bind": "jar/org/slf4j/slf4j_api"},
    {"artifact": "org.typelevel:cats-core_2.12:1.0.1", "lang": "scala", "sha1": "5872b9db29c3e1245f841ac809d5d64b9e56eaa1", "sha256": "9e1d264f3366f6090b17ebdf4fab7488c9491a7c82bc400b1f6ec05f39755b63", "repository": "https://repo.maven.apache.org/maven2/", "url": "https://repo.maven.apache.org/maven2/org/typelevel/cats-core_2.12/1.0.1/cats-core_2.12-1.0.1.jar", "source": {"sha1": "a59993540e8aaa8b7b5941642665e69e0748b08f", "sha256": "343630226130389da2a040c1ee16fc1e0c4be625b19b2591763e0d20236a3b9f", "repository": "https://repo.maven.apache.org/maven2/", "url": "https://repo.maven.apache.org/maven2/org/typelevel/cats-core_2.12/1.0.1/cats-core_2.12-1.0.1-sources.jar"} , "name": "org_typelevel_cats_core_2_12", "actual": "@org_typelevel_cats_core_2_12//jar:file", "bind": "jar/org/typelevel/cats_core_2_12"},
    {"artifact": "org.typelevel:cats-effect_2.12:0.10", "lang": "scala", "sha1": "457a41f51707e64d010520f9d63f7f6a762ff7f5", "sha256": "e8e9f493c0a45d4ca5367e3ac133e39cf2d52499e2bf7adf5c589299e6a19cfb", "repository": "https://repo.maven.apache.org/maven2/", "url": "https://repo.maven.apache.org/maven2/org/typelevel/cats-effect_2.12/0.10/cats-effect_2.12-0.10.jar", "source": {"sha1": "29235744c9090f69ea388de7fbadc7d48fbe1b73", "sha256": "90bea5766a154f715ab70b65c5561d13fec3a2b6b7996ac7e70a4656969f64eb", "repository": "https://repo.maven.apache.org/maven2/", "url": "https://repo.maven.apache.org/maven2/org/typelevel/cats-effect_2.12/0.10/cats-effect_2.12-0.10-sources.jar"} , "name": "org_typelevel_cats_effect_2_12", "actual": "@org_typelevel_cats_effect_2_12//jar:file", "bind": "jar/org/typelevel/cats_effect_2_12"},
    {"artifact": "org.typelevel:cats-kernel_2.12:1.0.1", "lang": "scala", "sha1": "977ec6bbc1677502d0f6c26beeb0e5ee6c0da0ad", "sha256": "d87025b6fb7f403d767f6fa726c1626c9c713927bdc6b2a58ac07a32fec7490d", "repository": "https://repo.maven.apache.org/maven2/", "url": "https://repo.maven.apache.org/maven2/org/typelevel/cats-kernel_2.12/1.0.1/cats-kernel_2.12-1.0.1.jar", "source": {"sha1": "b26244b22edd48e9173e1cae03d01244d597330d", "sha256": "4cfb3519fc4c7c6da339c614704cee1a9fa89357821ad9626b662dc7b5b963b9", "repository": "https://repo.maven.apache.org/maven2/", "url": "https://repo.maven.apache.org/maven2/org/typelevel/cats-kernel_2.12/1.0.1/cats-kernel_2.12-1.0.1-sources.jar"} , "name": "org_typelevel_cats_kernel_2_12", "actual": "@org_typelevel_cats_kernel_2_12//jar:file", "bind": "jar/org/typelevel/cats_kernel_2_12"},
    {"artifact": "org.typelevel:cats-macros_2.12:1.0.1", "lang": "scala", "sha1": "89374609c1ffe142c7fec887883aff779befb101", "sha256": "c17a5625d9a203fa4676cb80ba22f65e68d18497945d24370bac9123ddc3da28", "repository": "https://repo.maven.apache.org/maven2/", "url": "https://repo.maven.apache.org/maven2/org/typelevel/cats-macros_2.12/1.0.1/cats-macros_2.12-1.0.1.jar", "source": {"sha1": "412d4e8cae3b7aeca5e841712ef57ec614d01c4e", "sha256": "456b745024e4836a78967f9edb9e5db09a7af352ad161b44188960be90d22702", "repository": "https://repo.maven.apache.org/maven2/", "url": "https://repo.maven.apache.org/maven2/org/typelevel/cats-macros_2.12/1.0.1/cats-macros_2.12-1.0.1-sources.jar"} , "name": "org_typelevel_cats_macros_2_12", "actual": "@org_typelevel_cats_macros_2_12//jar:file", "bind": "jar/org/typelevel/cats_macros_2_12"},
    {"artifact": "org.typelevel:machinist_2.12:0.6.2", "lang": "scala", "sha1": "a0e8521deafd0d24c18460104eee6ce4c679c779", "sha256": "b7e97638fa25ba02414b9b8387e9ecc2ea2fce4c9d9068ac3108ee5718b477a9", "repository": "https://repo.maven.apache.org/maven2/", "url": "https://repo.maven.apache.org/maven2/org/typelevel/machinist_2.12/0.6.2/machinist_2.12-0.6.2.jar", "source": {"sha1": "98df07f657cb11f112eb84070da52e3951461ab6", "sha256": "739d6899f54e3c958d853622aec7e5198a719a2906faa50199189b0289ebef83", "repository": "https://repo.maven.apache.org/maven2/", "url": "https://repo.maven.apache.org/maven2/org/typelevel/machinist_2.12/0.6.2/machinist_2.12-0.6.2-sources.jar"} , "name": "org_typelevel_machinist_2_12", "actual": "@org_typelevel_machinist_2_12//jar:file", "bind": "jar/org/typelevel/machinist_2_12"},
    {"artifact": "org.typelevel:macro-compat_2.12:1.1.1", "lang": "scala", "sha1": "ed809d26ef4237d7c079ae6cf7ebd0dfa7986adf", "sha256": "8b1514ec99ac9c7eded284367b6c9f8f17a097198a44e6f24488706d66bbd2b8", "repository": "https://repo.maven.apache.org/maven2/", "url": "https://repo.maven.apache.org/maven2/org/typelevel/macro-compat_2.12/1.1.1/macro-compat_2.12-1.1.1.jar", "source": {"sha1": "ade6d6ec81975cf514b0f9e2061614f2799cfe97", "sha256": "c748cbcda2e8828dd25e788617a4c559abf92960ef0f92f9f5d3ea67774c34c8", "repository": "https://repo.maven.apache.org/maven2/", "url": "https://repo.maven.apache.org/maven2/org/typelevel/macro-compat_2.12/1.1.1/macro-compat_2.12-1.1.1-sources.jar"} , "name": "org_typelevel_macro_compat_2_12", "actual": "@org_typelevel_macro_compat_2_12//jar:file", "bind": "jar/org/typelevel/macro_compat_2_12"},
    ]

def maven_dependencies(callback = jar_artifact_callback):
    for hash in list_dependencies():
        callback(hash)
