import React from 'react';
import { View, Text, StyleSheet, Dimensions, Animated } from 'react-native';

const visitors = [
    { name: 'John Doe', message: 'Please let me in!', time: '10:30 AM' },
    { name: 'Jane Smith', message: 'Delivery package.', time: '11:15 AM' },
    { name: 'Mike Brown', message: 'Here for a meeting.', time: '12:45 PM' },
    { name: 'Alice Green', message: 'Quick visit.', time: '1:30 PM' },
    { name: 'Tom White', message: 'Checking the meter.', time: '2:00 PM' },
];

const { width } = Dimensions.get('window'); // Screen width

export default function History() {
    const scrollX = React.useRef(new Animated.Value(0)).current;

    return (
        <View style={styles.container}>
            <Text style={styles.title}>Recent Visitors</Text>
            <Animated.ScrollView
                horizontal
                showsHorizontalScrollIndicator={false}
                pagingEnabled={false} // Disable default paging
                snapToInterval={width * 0.8} // Snap to the width of a card plus margin
                decelerationRate="fast" // Smooth snapping
                contentContainerStyle={styles.scrollContainer}
                onScroll={Animated.event(
                    [{ nativeEvent: { contentOffset: { x: scrollX } } }],
                    { useNativeDriver: false }
                )}
                scrollEventThrottle={16}
            >
                {/* Add padding to center the first and last cards */}
                <View style={{ width: (width - width * 0.75) / 2 }} />
                {visitors.map((visitor, index) => {
                    const inputRange = [
                        (index - 1) * width * 0.8,
                        index * width * 0.8,
                        (index + 1) * width * 0.8,
                    ];
                    const scale = scrollX.interpolate({
                        inputRange,
                        outputRange: [0.9, 1, 0.9],
                        extrapolate: 'clamp',
                    });

                    return (
                        <Animated.View
                            key={index}
                            style={[
                                styles.card,
                                { transform: [{ scale }] }, // Scale animation
                            ]}
                        >
                            <Text style={styles.visitorName}>{visitor.name}</Text>
                            <Text style={styles.message}>{visitor.message}</Text>
                            <Text style={styles.time}>{visitor.time}</Text>
                        </Animated.View>
                    );
                })}
                <View style={{ width: (width - width * 0.75) / 2 }} />
            </Animated.ScrollView>
        </View>
    );
}

const styles = StyleSheet.create({
    container: {
        flex: 1,
        backgroundColor: '#f0f0f0',
        paddingTop: 20,
    },
    title: {
        fontSize: 24,
        fontWeight: 'bold',
        color: '#333',
        textAlign: 'center',
        marginBottom: 20,
    },
    scrollContainer: {
        alignItems: 'center',
    },
    card: {
        width: width * 0.75, 
        height: 100, 
        padding: 15,
        backgroundColor: '#fff',
        borderRadius: 15,
        marginHorizontal: 5,
        shadowColor: '#000',
        shadowOpacity: 0.1,
        shadowRadius: 8,
        shadowOffset: { width: 0, height: 5 },
        alignItems: 'center',
        justifyContent: 'center',
    },
    visitorName: {
        fontSize: 18,
        fontWeight: 'bold',
        color: '#333',
        marginBottom: 5,
    },
    message: {
        fontSize: 14,
        color: '#555',
        marginBottom: 5,
    },
    time: {
        fontSize: 12,
        color: '#888',
    },
});
