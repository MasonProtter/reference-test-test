using Test, ReferenceTests, Plots, FileWatching

reference_test_watcher = Threads.@spawn begin
    watch_folder("imgs/")
    error()
end

@testset "plt" begin
    xs = 1:0.01:10
    ys = sin.(xs) .+ rand() ./ 10
    plt = plot(xs, ys)
    @test_reference "imgs/noisy_sin.png" plt by=psnr_equality(50)
    @test !istaskfailed(reference_test_watcher)
end
