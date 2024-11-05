export function assert_test(conditional: boolean, message: string) {
    if (!conditional) {
        throw new Error(message);
    }
}
